# PHP Dockerization Demo

How to Dockerize a PHP application in different environments 

## Requirements

* Install [Docker](https://docs.docker.com/install/)

* Install [Docker Compose](https://docs.docker.com/compose/install/)

* Install [Minikube](https://minikube.sigs.k8s.io/docs/start/)

* Install [kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl)

## Run PHP in Local Docker Environment

Launch local version with Docker Compose
```bash
docker compose up -d
```

Open URL http://localhost:8080/ You will see information about PHP provided by phpinfo() function

Stop containers and remove all related resources
```bash
docker compose down
```

## Build Docker image with the source code 

Build command with SOURCE_FOLDER build argument
```bash
docker build --force-rm=true \
    --tag="php-docker-env-demo-code" \
    --build-arg="SOURCE_FOLDER=/source" \
    --file="Dockerfile" --no-cache .
```

Authorize to Docker Registry (Docker Hub)
```bash
docker login -u <your-dockerhub-username> --password-stdin
```

Push Docker image to Docker Hub Registry
```bash
docker tag php-docker-env-demo-code <your-dockerhub-username>/php-docker-env-demo-code:latest
docker push <your-username>/php-docker-env-demo-code:latest
```

Public Docker image with the source code is available here
https://hub.docker.com/r/luxurydab/php-docker-env-demo-code

## Run PHP in Docker Swarm environment

Create a new Swarm cluster
```bash
docker swarm init --advertise-addr 127.0.0.1
```
Note: 127.0.0.1 is the manager IP address. You can use 127.0.0.1 to play on your local machine. Use the IP address of your server in Live / Production environment

Deploy Docker Swarm cluster
```bash
docker stack deploy --compose-file docker-stack.yml docker-swarm-demo
```

Open URL http://127.0.0.1/ You will see PHP page running in Docker Swarm

Remove services from Docker Swarm
```bash
docker service rm docker-swarm-demo_code docker-swarm-demo_nginx docker-swarm-demo_php
```

Leave the Docker Swarm
```bash
docker swarm leave --force
```

## Run PHP in minikube (local Kubernetes) environment

Start minikube
```bash
minikube config set vm-driver docker
minikube start --cpus=2 --memory=2048 --alsologtostderr
```

Switch to minikube environment
```bash
eval $(minikube docker-env)
```

Deploy PHP to minikube environment
```bash
kubectl apply -f minikube.yaml
```

Get URL to nginx service
```bash
minikube service nginx --url
```

Stop and delete minikube
```bash
eval $(minikube docker-env -u)
minikube stop
minikube delete
```