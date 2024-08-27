### Introduction

This project is continuation of the [previous project]() where I have created a few microservices. In this project, I have created an orchestrator service which will be responsible for orchestrating the microservices. The orchestrator service will be responsible for the following tasks:

Docker images from microservices build from the previous project and deployed to the Docker Hub.

To run infrastructure you need to have Vagrant and VirtualBox installed on your machine. You can download Vagrant from [here](https://www.vagrantup.com/downloads.html) and VirtualBox from [here](https://www.virtualbox.org/wiki/Downloads).

### Steps to run the infrastructure

1. Clone the repository to your local machine.
2. Navigate to vagrant directory and run `vagrant up` command.
3. Once the infrastructure is up and running, navigate to Scripts directory and run `./orchestrator.sh` script.

Now application is up and running. You can access docs at http://192.168.56.30/api-docs