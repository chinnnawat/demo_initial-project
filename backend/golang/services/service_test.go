package service

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestAdd(t *testing.T) {
	result := Add(8, 3)

	assert.Equal(t, 11, result)
}

func TestDelete(t *testing.T) {
	result := Delete(8, 3)

	assert.Equal(t, 5, result)
}
