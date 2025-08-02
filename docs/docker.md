# 📘 Docker Commands Reference

This repository contains a curated list of essential `docker` commands for managing docker containers and images efficiently. Useful for daily reference and quick lookups.

## 🔍 Container Image Registries
Below are the popular docker registries -

### Registries with Public Images
1. [Docker Hub](https://hub.docker.com)
2. [Quay](https://quay.io)

### Registries to store the images
Below registries are used only to store the images -
1. [Harbor (Self-hosted)](https://goharbor.io)
2. [Nexus (Self-hosted)](https://help.sonatype.com/en/docker-registry.html)
3. [Jfrog](https://jfrog.com/artifactory/)
4. [Github Container Registry](https://ghcr.io)
5. [GitLab Container Registry](https://docs.gitlab.com/ee/user/packages/container_registry)
6. [Google Artifact Registry - GAR](https://cloud.google.com/artifact-registry)
7. [Azure Container Registry - ACR](https://azure.microsoft.com/en-us/products/container-registry)
8. [AWS Elastic Container Registry - ECR](https://aws.amazon.com/ecr/)

---

## 🧱 Useful Commands

```bash
# 1. Commands related to images

# 1.1 List all the locally availabe images
docker images
docker image ls

# 1.2 Pull the image from public repository in docker hub
docker pull <image_name>:<tag>

# 1.3 Pull the docker image from a private repository
docker login -u <username>
docker pull <image_name>:<tag>

# Example: docker pull anupaminit/fdn-tst-docker-images:tagname

# 1.4 Push the docker image to docker hub registry
docker push <image_name>:<tag>

# 1.5 Renaming a Docker image with a new tag
docker tag <source_name>[:<tag>] <target_name>[:<tag>]

# What are dangling images:
# A dangling image is an untagged Docker image that is not associated with any container. Dangling images are created when an image is overwritten with a new image that has the same name and tag.
# Note: These images can be created if you're creating/building the image with --no-cache option while using the same name and tag of an exisitng image. So the old image you have becomes the "dangling image".
docker build -t sampleapp:v1.0.0 . --progress=plain --no-cache

# Dangling images appear in Docker image listings as <none>:<none>. The first <none> refers to the repository name of the image, and the second <none> refers to the tag of the image.
# To clean up unused images, you can use the `docker image prune` command. By default, `docker image prune` only cleans up dangling images.
docker image prune


# 2. Commands related to containers

# 2.1 Run a docker container with a specific name
docker run --name [container_name] [docker_image]

# 2.2 To start a Docker container in the foreground of the terminal based on an existing Docker image, you can use the docker run command as follows:
docker run -it <image>

# Where:
# The -i flag is used to launch the container in interactive mode, allowing it to accept input from the command line.
# A terminal is needed to interact with a computer’s operating system using text-based commands. By default, docker does not attach a terminal to a container when it runs. The -t flag is used to allocate a terminal within the container, making it behave like a regular terminal interface.

# 2.3 To start a container in the background (i.e. "detached mode"), you can use the docker run command with the -d flag as follows:
docker run -d < image>

# List, Stop and delete all the docker containers
docker ps -a # List all the containers
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

# Where:
# $(...) is used for command substitution in Bash, taking the output of the enclosed command and replacing it in the outer command.
# `docker ps -a -q` command lists all the Docker container IDs. The -a flag lists all containers, including the ones that have stopped, and the -q flag outputs only the
# container IDs.

# Note: you can restart a container using `docker restart container_id`, read the article from reference section.

# 2.5 Exposing a port:
# In Docker, exposing and publishing ports have different meanings.
# Publishing a port refers to making the services running inside a container accessible to the outside world by mapping a container port to a host port
# Exposing a port, on the other hand, simply informs Docker that the port is available for communication between containers, but does not make it accessible from outside the Docker network unless it is also published.

# To map a host port to a container port, you can use the docker run  command with the -p  flag (short for --publish ) as follows:
docker run -p <host_port>:<container_port> <image>

# In Docker, it is quite common for a single container to run multiple services that require different ports to listen for incoming requests. To publish multiple ports at once, you can repeat the -p  flag several times using the following syntax:
docker run -p <host_port>:<container_port> [-p <host_port>:<container_port>] <image>

# Mapping exposed ports to random host ports
# When launching a container, you can map the ports exposed through the EXPOSE  property or the --expose  flag to random ports on the host machine using the docker run  command with the -P  flag (short for --publish-all ) as follows:
docker run -P <image>

# Once launched, you can find out the port mapping of your container using the docker port  command as follows:
docker port <container_id>

# 2.6 Examine a container's metadata (like entrypoint, command instructions etc) in Docker by using Docker inspect:
docker inspect [container_id]

# 2.7 Check the logs of the container
docker logs <container_id>
# To monitor the logs of a docker container in real-time, you can use the docker logs command with the -f flag (short for --follow):
docker logs -f <container_id>
# Outputting the last N logs. To show the latest log entries, you can use the --tail option, followed by the number of logs to display:
docker logs --tail <number> <container_id>

# 2.8 Execute a command
# To execute a command inside a container running in detached mode (i.e., the background), you can use the docker exec command as follows:
# By default, the specified command will be executed inside of the container as the root user. To execute a command as a non-root user, you can use the docker exec command with the -u flag (short for --user)
docker exec <container> <command>
docker exec http-server ls

# Starting an interactive shell session
# To facilitate the execution of commands in a container for debugging, performing administrative tasks, or simply testing, you can start an interactive shell session that provides direct access to the container's shell using the -it flags (short for --interactive and --tty) as follows:
docker exec -it <container> <shell>

# where:
# shell is the absolute path to a shell binary installed in the container.

# For example, the following command will start an interactive shell session using Bash in the container named ubuntu:
docker exec -it ubuntu /bin/bash

# 2.9 Map a volumen with a docker container
# it will map the /var/lib/jenkins of container to mentioned host directory.
docker run -v /opt/datadir:/var/lib/jenkins jenkins:jenkins
```

## 📌 How to Contribute

Feel free to fork this repo and add your favorite kubectl commands!

## 🔗 References
- https://www.warp.dev/terminus/docker-expose-port
- https://www.warp.dev/terminus/docker-restart-container
