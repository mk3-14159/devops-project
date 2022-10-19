# Devops Project Demo 
---
This repository contains a collection of implementations for the devops tools required in my technical interview and project showcase (20/10/2022)
[Trello Link](https://trello.com/b/lecakUAx/ci-cd-pipeline-project-a-compelte-infrastructure-automation-story)

### Introduction
I have been tasked to learn more about the CI / CD development stack eg. Jenkins, codify, terraform, ansible, github actions etc. This is a deveops project dedicated to showcase my learning and 





### Specification 
The following collection of tools I have used setup a Devops CI/CD pipeline to deploy a fullstack application


### IntellBB Download instructions

[original repo](https://github.com/flaskbb/flaskbb)

```
git checkout 2.0.0


# Build
virtualenv .venv
source .venv/bin/activate
pip3 install -r requirements.txt
flaskbb install

flaskbb --config flaskbb.cfg run
flaskbb --config flaskbb.configs.default.DefaultConfig run
```



### tools utilised
1. git
2. Docker
3. Terraform
4. Jenkins
5. Ansible plugins
6. Github Actions



### 1. Setting up the production github repo
  1. fork the repo
  2. clone to machine
  3. setting up ssh 



### 2. Setting up jenkins server using docker container
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


### 3. Setting up a Jenkins agent using terraform

### 4. Setting up Terraform to deploy an EC2 instance to host our jenkins dev server
  1. terraform init - initialize terraform based on your  configurations
  2. terraform plan - runs sanity check on the .tf script to make sure everything is G 
  3. terraform apply -  applies the changes that will take place
  4. creating a vpc for a test server
  5. use EOF to install all the dependencies for FlaskBB

### Jenkins
build trigger when changes are made [47 mins](https://www.youtube.com/watch?v=6YZvp2GwT0A)

  - Install / Setup Master
  - Setup up a cloud agent using docker
  - Setting up a declarative pipeline (groovy)

Challenges
  1. In Jenkins pipelines, the stages of development are followed upstream eg. build -> test -> deliever. It means when tests fail deliver will default to a failed build

Solution
  2. 

| Challenges | Solution | 
| :---       | :---     |
|  In Jenkins pipelines, the stages of development are followed upstream eg. build -> test -> deliever. It means when tests fail deliver will default to a failed build | Debug the pipelines from levels, make sure the lower levels build before debugging the delivery stage



### Ansible


### Github Actions

