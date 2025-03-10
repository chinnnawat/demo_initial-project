FROM python:3.13.2-slim-bullseye

WORKDIR /app

RUN apt update && apt install -y curl 2ping iputils-ping git

# display standard output
ENV PYTHONUNBUFFERED=1

# install dependencies
COPY requirements.txt /app
RUN pip install -r requirements.txt --no-cache-dir

# add user vscode
RUN adduser --disabled-password --gecos "" vscode
RUN groupadd docker
RUN usermod -aG docker vscode

USER vscode
