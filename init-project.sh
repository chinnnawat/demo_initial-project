#!/bin/bash

# Project name (default: todo-app)
PROJECT_NAME=${1:-todo-app}

echo "Creating project: $PROJECT_NAME"

# Create root directory and subdirectories
mkdir -p "$PROJECT_NAME/backend" "$PROJECT_NAME/frontend"
cd "$PROJECT_NAME" || exit

# --- Backend Setup ---
echo "Setting up Go backend..."

# Initialize Go module
cd backend
go mod init "$PROJECT_NAME/backend"
go get -u github.com/gin-gonic/gin gorm.io/driver/postgres gorm.io/gorm

# Create main.go
cat << 'EOF' > main.go
package main

import (
	"net/http"
	"github.com/gin-gonic/gin"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

type Todo struct {
	ID    int    `json:"id" gorm:"primaryKey"`
	Title string `json:"title"`
	Done  bool   `json:"done"`
}

var db *gorm.DB

func initDB() {
	dsn := "host=postgres user=postgres password=postgres dbname=todo_db port=5432 sslmode=disable"
	var err error
	db, err = gorm.Open(postgres.Open(dsn), &gorm.Config{})
	if err != nil {
		panic("failed to connect database: " + err.Error())
	}
	db.AutoMigrate(&Todo{})
	if db.Migrator().HasTable(&Todo{}) && db.Find(&[]Todo{}).RowsAffected == 0 {
		db.Create(&Todo{Title: "Learn Go", Done: false})
		db.Create(&Todo{Title: "Build an API", Done: false})
	}
}

func main() {
	initDB()
	r := gin.Default()
	r.Use(func(c *gin.Context) {
		c.Writer.Header().Set("Access-Control-Allow-Origin", "http://localhost:3000")
		c.Writer.Header().Set("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE")
		c.Writer.Header().Set("Access-Control-Allow-Headers", "Content-Type")
		if c.Request.Method == "OPTIONS" {
			c.AbortWithStatus(http.StatusNoContent)
			return
		}
		c.Next()
	})
	r.GET("/todos", func(c *gin.Context) {
		var todos []Todo
		db.Find(&todos)
		c.JSON(http.StatusOK, todos)
	})
	r.POST("/todos", func(c *gin.Context) {
		var newTodo Todo
		if err := c.BindJSON(&newTodo); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}
		db.Create(&newTodo)
		c.JSON(http.StatusCreated, newTodo)
	})
	r.Run(":8080")
}
EOF

# Create .air.toml
cat << 'EOF' > .air.toml
root = "."
tmp_dir = "tmp"

[build]
  bin = "./tmp/main"
  cmd = "go build -o ./tmp/main ."
  delay = 1000
  exclude_dir = ["tmp"]
  include_ext = ["go", "tpl", "tmpl", "html"]

[log]
  time = true

[misc]
  clean_on_exit = true
EOF

# Create Dockerfile for backend with Go 1.24-alpine
cat << 'EOF' > Dockerfile
FROM golang:1.24-alpine AS dev
WORKDIR /app
RUN go install github.com/air-verse/air@latest
COPY go.mod go.sum ./
RUN go mod download
COPY . .
EXPOSE 8080
CMD ["air"]

FROM golang:1.24-alpine AS prod
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN go build -o main .
EXPOSE 8080
CMD ["./main"]
EOF

cd ..

# --- Frontend Setup ---
echo "Setting up Next.js frontend..."
npx create-next-app@14 frontend --typescript --tailwind --eslint --app --no-src-dir --yes

cd frontend

# Create lib/api.ts
mkdir -p lib
cat << 'EOF' > lib/api.ts
export interface Todo {
  id: number;
  title: string;
  done: boolean;
}

export async function fetchTodos(): Promise<Todo[]> {
  const res = await fetch('http://localhost:8080/todos');
  if (!res.ok) throw new Error('Failed to fetch todos');
  return res.json();
}

export async function addTodo(title: string): Promise<Todo> {
  const res = await fetch('http://localhost:8080/todos', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ title, done: false }),
  });
  if (!res.ok) throw new Error('Failed to add todo');
  return res.json();
}
EOF

# Update app/page.tsx
cat << 'EOF' > app/page.tsx
'use client';

import { useState, useEffect } from 'react';
import { fetchTodos, addTodo, Todo } from '../lib/api';

export default function Home() {
  const [todos, setTodos] = useState<Todo[]>([]);
  const [newTodo, setNewTodo] = useState('');

  useEffect(() => {
    fetchTodos()
      .then(setTodos)
      .catch(err => console.error(err));
  }, []);

  const handleAddTodo = async () => {
    if (!newTodo.trim()) return;
    try {
      const todo = await addTodo(newTodo);
      setTodos([...todos, todo]);
      setNewTodo('');
    } catch (err) {
      console.error(err);
    }
  };

  return (
    <div className="max-w-md mx-auto p-4">
      <h1 className="text-2xl font-bold mb-4">Todo List</h1>
      <ul className="mb-4">
        {todos.map(todo => (
          <li key={todo.id} className="py-2">
            {todo.title} ({todo.done ? 'Done' : 'Pending'})
          </li>
        ))}
      </ul>
      <div className="flex gap-2">
        <input
          type="text"
          value={newTodo}
          onChange={e => setNewTodo(e.target.value)}
          onKeyUp={e => e.key === 'Enter' && handleAddTodo()}
          placeholder="New todo"
          className="flex-1 p-2 border rounded"
        />
        <button
          onClick={handleAddTodo}
          className="px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600"
        >
          Add
        </button>
      </div>
    </div>
  );
}
EOF

# Create Dockerfile for frontend
cat << 'EOF' > Dockerfile
FROM node:18-alpine
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build
EXPOSE 3000
CMD ["npm", "start"]
EOF

cd ..

# --- Docker Compose Setup ---
echo "Setting up Docker Compose..."
cat << 'EOF' > docker-compose.yml
version: '3.8'
services:
  backend:
    build:
      context: ./backend
      target: dev
    ports:
      - "8080:8080"
    container_name: go-backend
    depends_on:
      - postgres
    environment:
      - POSTGRES_HOST=postgres
      - POSTGRES_USER=postgres
      - POSTGRES_PASSWORD=postgres
      - POSTGRES_DB=todo_db
    volumes:
      - ./backend:/app

  frontend:
    build: ./frontend
    ports:
      - "3000:3000"
    container_name: next-frontend
    depends_on:
      - backend

  postgres:
    image: postgres:15-alpine
    container_name: postgres
    environment:
      - POSTGRES_USER=postgres
      - POSTGRES_PASSWORD=postgres
      - POSTGRES_DB=todo_db
    ports:
      - "5432:5432"
    volumes:
      - postgres-data:/var/lib/postgresql/data

volumes:
  postgres-data:
EOF

echo "Project setup complete! Run 'cd $PROJECT_NAME && docker-compose up --build' to start."