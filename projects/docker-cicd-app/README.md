
# Dockerized Web Application with GitHub Actions CI

A simple static web application containerized using Docker and served through Nginx. GitHub Actions automatically builds the Docker image whenever code is pushed to the main branch or a pull request targets main.

## Project Overview

This project demonstrates:
- Docker image creation using a Dockerfile
- Containerization of a static HTML application
- Hosting with Nginx Alpine
- Port mapping and container management
- Automated Docker build validation using GitHub Actions

## Technology Stack

- Linux
- Docker
- Nginx
- HTML and CSS
- Git and GitHub
- GitHub Actions

## Architecture

Developer → Git Push → GitHub Repository → GitHub Actions → Docker Image Build

## Project Structure

```text
docker-cicd-app/
├── Dockerfile
├── index.html
└── README.md

.github/
└── workflows/
    └── docker-ci.yml
```

## Run Locally

Build the Docker image:

```bash
docker build -t kartik-docker-app:v1 .
```

Run the container:

```bash
docker run -d --name kartik-web -p 8081:80 kartik-docker-app:v1
```

Open in your browser:

http://localhost:8081

Check running containers:

```bash
docker ps
```

Stop the container:

```bash
docker stop kartik-web
```

Remove the container:

```bash
docker rm kartik-web
```

## CI Pipeline

GitHub Actions runs automatically on:
- Push to main
- Pull requests targeting main

The workflow checks out the repository and builds the Docker image on an Ubuntu runner.

## CI Status

The initial Docker CI workflow completed successfully.

## Author

Kartik Verma

GitHub: https://github.com/Developer-Kartik
