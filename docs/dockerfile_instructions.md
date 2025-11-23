# 📘 Dockerfile Instructions Reference
This repository contains a curated list of essential Dockerfile instructions for creating docker images efficiently. Useful for daily reference and quick lookups.

## 🧱 Useful Commands
A docker file is text file that contains all the instructions that a user provide to assemble an image. Each instruction creates a new image layer on the base image. Instructions are nothing but they specify what to do when building the image. Docker file must be created with the name "Dockerfile" with "D" as capital. It must not have any extension.

```bash
# 1. Dockerfile instructions
# Docker files are written in below format. There are multiple keywords that we use in Docker File to pass a certain instruction. Some of them are as follows:
INSTRUCTION arguments

# 2. WORKDIR: This instruction in Dockerfile will also create a directory if it does not exist. This is because the WORKDIR command sets the working directory for any subsequent instructions in the Dockerfile. If the specified directory does not exist, Docker will create it automatically.
# For example, the following Dockerfile will create a directory called /my-work-dir and then change the working directory to that directory:

WORKDIR /my-work-dir

# In Unix, this is the equivalent of the following command:
mkdir dir && cd dir

# You should always use WORKDIR instead of using RUN cd .. something.

# 3. COPY: The COPY instruction copies the specified files and directories in their existing format. This limitation affects the compressed files, which are copied as-is, i.e., without extraction. and that's where we use ADD command. Overall, COPY works with locally stored files only. The COPY command in Dockerfile can create a directory, If <dest> does not exist.
# The syntax is: COPY <src> <dest>
# Where:
# <src> is the path to the file or directory to be copied.
# <dest> is the path to the destination in the Docker image.

# Unlike with the linux cp command, the COPY instruction allows you to copy multiple sources at once–which can be files, directories, or both–by separating them with a whitespace character:
COPY file.txt dir /app

# Also note that when copying a directory, only the content of the directory will be copied, but not the directory itself. For example, the following command will copy the content of the dir directory into the /app directory:
COPY dir /app

# It is important to note that the paths of the source files and directories will be interpreted as relative to the source of the context of the build, which means that only the files contained in the directory where the Dockerfile is located will be copied. You can therefore copy the entire directory of the build context using the dot notation:
COPY . /app

# But you cannot copy files that are outside of the build context of the Dockerfile: The below command will not work -
COPY ../file.txt /app

# The destination path may either be an absolute path:
COPY file /appRun

# Or a path relative to the one specified in the `WORKDIR` instruction:
WORKDIR /app
COPY file .

# ADD: This instruction can not only copy the files but also allows us to download a file from internet and copy to the container. This instruction also has the ability to unpack the compressed files. Use COPY for the sake of transparency unless you are pretty sure that you need ADD.

# 4. You can add comments to the Docker File with the help of the # command.
# This is a sample Image

# 5. FROM: To tell docker, from which base image you want to create your image. A docker file must start with FROM statement.
FROM ubuntu:latest

# 6. MAINTAINER: Use the following command, to mention the person who is going to maintain this image.
MAINTAINER anupam-sy

# 7. RUN: Use "RUN" command to run instructions against the image.
RUN apt-get update
RUN apt-get install -y vim

# 8. CMD: This instruction specifies the default program that will execute once the container runs. This keyword is allowed only once (if many, then only the last one takes effect). These instructions doesn't run when building the images but they run when container starts up.
# Eg: Say the docker file (Dockerfile.01) has below instruction.
CMD ["echo", "hello world"]

# In case of CMD, the command line parameters will get replaced entirely. Whereas in case of Entrypoint, the command line parameters, will get appended to the ENTRYPOINT instruction. In the below example, If the user passed the parameter from command line with `docker run`, default CMD instruction will be overridden/replaced. In the below case, it will echo -> hello anupam
docker run ubuntu-cmd:v1.0 echo hello anupam

# but, below command will throw the error. see the explanation below -
docker run ubuntu-cmd:v1.0 hello anupam

# REMEMBER: When overriding CMD using docker run, you must specify a valid executable command followed by its arguments. If you omit the command, Docker will assume the first argument is the command itself, leading to potential errors if it's not a recognized executable within the container's environment.

# Exec form: The exec form is parsed as a JSON array, which means that you must use double-quotes (") around words, not single-quotes ('). There could be multiple parameters.
CMD ["command", "param"]
CMD ["/bin/bash", "-c", "echo hello"]
# Shell form: Unlike the exec form, instructions using the shell form always use a command shell.
CMD command param

# You can change the default shell using the SHELL command. For example:
SHELL ["/bin/bash", "-c"]
RUN echo hello

# 9. ENTRYPOINT: ENTRYPOINT is same as CMD instruction means ENTRYPOINT instruction is used to set an executables that will always run when the container starts running. But, ENTRYPOINT instructions are not ignored or overridden, instead command line arguments are appended, if passed.
# Eg: Say the docker file (Dockerfile.02) has below instruction.
ENTRYPOINT ["echo", "hello world"]

# USECASE
# In case of CMD, the command line parameters will get replaced entirely. Whereas in case of Entrypoint, the command line parameters, will get appended to the ENTRYPOINT instruction. In the below example, If the user passed the parameters from command line with `docker run`, parameters will be appended to default ENTRYPOINT instruction. In the below case, it will echo -> hello world hello anupam
docker run ubuntu-ep:v1.0 hello anupam

# and thats the reason, we usually use ENTRYPOINT instruction with command only and use CMD instruction in the end to make it treated as default argument to ENTRYPOINT, if no command line parameters are passed. Example below -
# Eg: Say the docker file (Dockerfile.03) has below instruction.
ENTRYPOINT ["echo"]
CMD ["hello world"]

# If we run `docker run` command with a parameter like below, it will be replaced and then appended to ENTRYPOINT. Hence it will echo -> hello anupam
docker run ubuntu-mixed:v1.0 hello anupam

# If we run `docker run` command without any parameter, it will echo - hello world
docker run ubuntu-mixed:v1.0

# NOTE: what if you use a command in ENTRYPOINT that must need atleast one argument? Then if you do not use the CMD instruction and not pass any parameter, your container will throw the error. Hence use a CMD instruction to pass atleast one argument to ENTRYPOINT.

# Here's what happens
# ENTRYPOINT defines the executable: The ENTRYPOINT instruction always sets the primary command or executable that will run when the container starts.
# CMD provides default arguments to the ENTRYPOINT: The CMD instruction's role shifts to providing default arguments to the ENTRYPOINT command, not overriding it.
# docker run arguments override CMD arguments: Any arguments passed to the docker run command will override the arguments defined in CMD, but they will be appended to the executable defined by ENTRYPOINT

# REMEMBER:
# Opt for ENTRYPOINT instruction when building an executable Docker image using commands that always need to be executed. CMD instructions are best for an additional set of arguments that act as default instructions till there is an explicit command line usage when a Docker container runs.

# Opt for CMD instruction, if you want the command as well as parameter to be replaced.

# NOTE: if you ever need to replace the ENTRYPOINT command, use the -> "--entrypoint python" when running docker container.

# HOW DOES THIS WORK IN KUBERNETES PODS?
# anything you want to append, should be passed as an argument using "args" key in EXEC form. So, the args field corresponds to CMD instruction in dockerfile, considering the above example.

apiVersion: v1
kind: Pod
metadata:
  name: eapp-pod
spec:
  containers:
    - name: ubuntu
      image: ubuntu-mixed:v1.0
      args: ["hello anupam"]

# what if we want to replace the ENTRYPOINT command itself? Then use the "command" key in the pod definition. So, the command field corresponds to ENTRYPOINT instruction in dockerfile, considering the above example.

apiVersion: v1
kind: Pod
metadata:
  name: eapp-pod
spec:
  containers:
    - name: ubuntu
      image: ubuntu-mixed:v1.0
      command: ["echo2"]
      args: ["hello anupam"]

# 10. EXPOSE: Exposing a port simply informs Docker that the port is available for communication between containers, but does not make it accessible from outside the Docker network unless it is also published. Example below -

EXPOSE 8080
```
