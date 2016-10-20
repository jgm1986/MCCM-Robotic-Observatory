FROM ubuntu:16.04
MAINTAINER Javier Gusano Martinez (jgm1986@hotmail.com)

# Install required packages.
RUN apt-get update -y
RUN apt-get install git lsb-release wget tar sudo sed software-properties-common -y

# Copy project files.
ADD . /home/rts2/
RUN cd /home/rts2 && \
	ls -ls && \
	sudo apt-get update && \
	/home/rts2/install/rts2/01-install.sh
WORKDIR /home/rts2

