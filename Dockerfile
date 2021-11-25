FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

# #GENERAL PACKAGES
RUN echo "export DISPLAY=:0"  >> /etc/profile
RUN apt-get -y update
RUN apt-get install python3 python3-pip -y
RUN pip3 install --upgrade pip

# #DEPENDENCIES FOR EASY MOCAP
RUN apt-get install python3-opencv freeglut3-dev git -y
RUN pip3 install opencv-python

# BUILD EASY MOCAP
WORKDIR /usr/src/easymocap
RUN git clone https://github.com/zju3dv/EasyMocap.git .
RUN pip3 install -r requirements.txt
RUN python3 setup.py develop --user