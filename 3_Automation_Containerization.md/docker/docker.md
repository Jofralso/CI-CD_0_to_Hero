# Automation and Containerization Tools - Docker

## Overview

Docker is a platform that enables developers to automate the deployment, scaling, and management of applications using containerization. Containers are lightweight, portable, and consistent environments that encapsulate an application and its dependencies, making them ideal for various stages of development and production.

## Detailed Explanation

### Basic Concepts

- **Containers**: Standalone, executable packages that include everything needed to run a piece of software, including the code, runtime, libraries, and system tools. Containers are isolated from each other and the host system.
  
- **Images**: Read-only templates used to create containers. Images contain the application code, libraries, and other dependencies.

- **Dockerfile**: A script with a set of instructions on how to build a Docker image. Example:
  ```dockerfile
  FROM ubuntu:20.04
  RUN apt-get update && apt-get install -y nginx
  COPY index.html /usr/share/nginx/html/index.html
  CMD ["nginx", "-g", "daemon off;"]
  ```

- **Docker Compose**: A tool for defining and running multi-container Docker applications using a YAML file. Example:
  ```yaml
  version: '3'
  services:
    web:
      image: nginx
      ports:
        - "80:80"
    db:
      image: postgres
      environment:
        POSTGRES_DB: mydb
        POSTGRES_USER: user
        POSTGRES_PASSWORD: password
  ```

### Advanced Concepts

- **Volumes**: Persistent storage solutions for Docker containers. Volumes allow data to persist beyond the lifecycle of a container. Example:
  ```bash
  docker run -v /host/path:/container/path image_name
  ```

- **Networking**: Docker provides several networking options, including bridge, host, and overlay networks. Example:
  ```bash
  docker network create my-network
  docker run --network my-network --name my-container image_name
  ```

- **Docker Swarm**: Docker’s native clustering and orchestration tool for managing a cluster of Docker nodes. It provides load balancing, scaling, and high availability.

- **Kubernetes**: An external container orchestration tool often used with Docker to manage complex deployments and scaling.

## Setup and Installation

### Installing Docker

1. **On Linux**:
   - **Install Docker**:
     ```bash
     sudo apt update
     sudo apt install docker.io
     sudo systemctl start docker
     sudo systemctl enable docker
     ```

   - **Add your user to the Docker group**:
     ```bash
     sudo usermod -aG docker $USER
     ```

2. **On macOS**:
   - **Install Docker Desktop** from the [official Docker website](https://www.docker.com/products/docker-desktop).

3. **On Windows**:
   - **Install Docker Desktop** from the [official Docker website](https://www.docker.com/products/docker-desktop).

4. **Verify Installation**:
   ```bash
   docker --version
   docker-compose --version
   ```

### Basic Commands

- **Run a Container**:
  ```bash
  docker run -d -p 80:80 --name my-nginx nginx
  ```

- **Build an Image**:
  ```bash
  docker build -t my-image .
  ```

- **Stop and Remove a Container**:
  ```bash
  docker stop my-container
  docker rm my-container
  ```

- **List Running Containers**:
  ```bash
  docker ps
  ```

- **List Images**:
  ```bash
  docker images
  ```

## Resources

- [Docker Official Documentation](https://docs.docker.com/)
- [Docker GitHub Repository](https://github.com/docker/docker-ce)
- [Docker Tutorials](https://docs.docker.com/get-started/)

## Exercises

### Easy Problem

**Task**: Write a Dockerfile to create a Docker image that runs a simple Python script.

**Solution**:

1. **Create Dockerfile**:
   ```dockerfile
   FROM python:3.8-slim
   COPY hello.py /app/hello.py
   CMD ["python", "/app/hello.py"]
   ```

2. **Create `hello.py`**:
   ```python
   print("Hello, Docker!")
   ```

3. **Build and Run**:
   ```bash
   docker build -t my-python-app .
   docker run my-python-app
   ```

### Medium Problem

**Task**: Write a Docker Compose file to set up a web server with Nginx and a PostgreSQL database.

**Solution**:

1. **Create `docker-compose.yml`**:
   ```yaml
   version: '3'
   services:
     web:
       image: nginx
       ports:
         - "80:80"
     db:
       image: postgres
       environment:
         POSTGRES_DB: mydb
         POSTGRES_USER: user
         POSTGRES_PASSWORD: password
   ```

2. **Run Docker Compose**:
   ```bash
   docker-compose up -d
   ```

### Hard Problem

**Task**: Write a Docker Compose file with a multi-container setup that includes a web application, a Redis cache, and a backend service. Ensure that the web application connects to the backend service and uses Redis for caching.

**Solution**:

1. **Create `docker-compose.yml`**:
   ```yaml
   version: '3'
   services:
     web:
       image: my-web-app
       depends_on:
         - backend
         - redis
       ports:
         - "8080:8080"
       environment:
         REDIS_URL: redis://redis:6379
         BACKEND_URL: http://backend:5000

     backend:
       image: my-backend-service
       ports:
         - "5000:5000"

     redis:
       image: redis
       ports:
         - "6379:6379"
   ```

2. **Run Docker Compose**:
   ```bash
   docker-compose up -d
   ```

## Cheat Sheet

### Basic Commands

- **Build Image**:
  ```bash
  docker build -t image_name .
  ```

- **Run Container**:
  ```bash
  docker run -d -p host_port:container_port --name container_name image_name
  ```

- **Stop Container**:
  ```bash
  docker stop container_name
  ```

- **Remove Container**:
  ```bash
  docker rm container_name
  ```

- **List Containers**:
  ```bash
  docker ps
  ```

- **List Images**:
  ```bash
  docker images
  ```

### Dockerfile Basics

- **Base Image**:
  ```dockerfile
  FROM base_image
  ```

- **Install Packages**:
  ```dockerfile
  RUN apt-get update && apt-get install -y package_name
  ```

- **Copy Files**:
  ```dockerfile
  COPY src_path dest_path
  ```

- **Set Command**:
  ```dockerfile
  CMD ["command", "arg1", "arg2"]
  ```

### Docker Compose Basics

- **Define Services**:
  ```yaml
  services:
    service_name:
      image: image_name
      ports:
        - "host_port:container_port"
  ```

- **Define Volumes**:
  ```yaml
  volumes:
    - host_path:container_path
  ```

- **Define Networks**:
  ```yaml
  networks:
    network_name:
      driver: bridge
  ```

