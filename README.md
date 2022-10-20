# Devops Project Demo 
---
This repository contains a collection of implementations for the devops tools required in my technical interview and project showcase (20/10/2022)
[Trello Link](https://trello.com/b/lecakUAx/ci-cd-pipeline-project-a-compelte-infrastructure-automation-story)

### Introduction
I have been tasked to learn more about the CI / CD development stack eg. Jenkins, codify, terraform, ansible, github actions etc. This is a deveops project dedicated to showcase my learning.

### tools utilised
1. git
2. Docker
3. Terraform
4. Jenkins
5. Ansible plugins
6. Github Actions

### Specification 
The following collection of tools I have used setup a Devops CI/CD pipeline to deploy a fullstack application

### Exercise 1 - IntelBB

[My fork of the FlaskkBB repo (IntelBB)](https://github.com/mk3-14159/intelbb)

![intelbb](https://github.com/mk3-14159/devops-project/blob/main/img/intelbb.png)

build instructions
```
git checkout 2.0.0
virtualenv .venv
source .venv/bin/activate
pip3 install -r requirements.txt
flaskbb install

flaskbb --config flaskbb.cfg run
flaskbb --config flaskbb.configs.default.DefaultConfig run
```

| Challenges | Solution | 
| :---       | :---     |
I after setting up an environment with main.tf, I cloned the repo into my EC2 instance - however due to my unfamiliarity with flask I could only run the flask app on localhost. Which meant that the application was not accessible to the public through the public dns | Utilised Apache2 or Gunicorn to deploy the flask application, or deploy a docker image of flaskBB with a preconfigured build

### Exercise 2 - Setting up jenkins server using docker container

[Jenkins Dockerfile](https://github.com/mk3-14159/devops-project/blob/main/Jenkins/Dockerfile)

![jenkins screenshot](https://static.filehorse.com/screenshots/developer-tools/jenkins-screenshot-01.png)

1. building the docker image for Jenkins 
```
docker build -t myjenkins-blueocean:2.332.3-1 .
```

2. create a network for jenkins 
*note* if a network already exists you can check by running

```
docker network ls
```
```
docker network create jenkins
```

3. run the jenkins container (BlueOcean)
```
docker run --name jenkins-blueocean --restart=on-failure --detach \
  --network jenkins --env DOCKER_HOST=tcp://docker:2376 \
  --env DOCKER_CERT_PATH=/certs/client --env DOCKER_TLS_VERIFY=1 \
  --publish 8080:8080 --publish 50000:50000 \
  --volume jenkins-data:/var/jenkins_home \
  --volume jenkins-docker-certs:/certs/client:ro \
  myjenkins-blueocean:2.332.3-1
```

4. Use docker exec to cat out the password
```
docker exec jenkins-blueocean cat /var/jenkins_home/secrets/initialAdminPassword

```

5. Checking if python3 exists within our container
*an easier way of doing this is to just ssh into the jenkins server*
```
docker exec -t jenkins-blueocean bash -c 'which python3'
```

| Challenges | Solution | 
| :---       | :---     |
| When testing the Docker build image (Dockerfile-py3-i386) on my local machine, it was taking too long to to build (over 15 minutes). | Utilize .dockerignore files to to exlude files from being sent on build and save time


### 3. Setting up GH Actins to deploy CI into EC2 instance using Terraform

[Repo Link - Use for demo](https://github.com/mk3-14159/simple-gha-terraform-project)

  1. terraform init - initialize terraform based on your  configurations
  2. terraform plan - runs sanity check on the .tf script to make sure everything is G 
  3. terraform apply -  applies the changes that will take place
  4. creating a vpc for a test server
  5. use EOF to install all my index.htmk
  6. Write Terraform.yml to automate the CI pipeline


| Challenges | Solution | 
| :---       | :---     |
| While I manage to deploy to EC2 Using Terraform with my AWS credentials hardcoded in main.tf, I could not do it through GH actions as it always gets stuck on the terraform apply step | I think the reason why GH Actions did not pass is due to a missed security verification step? eg. Terraform Cloud, AWS or github security


