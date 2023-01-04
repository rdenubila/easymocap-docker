FROM nvidia/cuda:11.5.0-cudnn8-runtime-ubuntu18.04

CMD ["bash"]
ENV DEBIAN_FRONTEND=noninteractive

RUN echo "export DISPLAY=:0"  >> /etc/profile
RUN apt-get -y update
RUN apt-get install python3.7 python3-pip -y 
RUN python3.7 -m pip install --upgrade pip setuptools wheel
RUN apt-get install python3-opencv -y
RUN apt-get install freeglut3-dev -y
RUN apt-get install -y --no-install-recommends python3-dev python3-pip git g++ wget make libprotobuf-dev protobuf-compiler libopencv-dev libgoogle-glog-dev libboost-all-dev libcaffe-cuda-dev libhdf5-dev libatlas-base-dev
RUN python3.7 -m pip install opencv-python==4.6.0.66
RUN apt-get install unzip ffmpeg -y
RUN python3.7 -m pip install mediapipe
RUN python3.7 -m pip install torch

WORKDIR /usr/src/easymocap
RUN git clone https://github.com/zju3dv/EasyMocap.git . 

WORKDIR /usr/src/easymocap/data/smplx
RUN wget https://www.denubila.com.br/downloads/smplx_models.zip
RUN unzip -n smplx_models.zip
RUN rm smplx_models.zip

WORKDIR /usr/src/easymocap
RUN python3.7 -m pip install -r requirements.txt 
RUN python3.7 setup.py develop --user

WORKDIR /usr/src/easymocap/scripts/postprocess
RUN wget https://www.denubila.com.br/downloads/convert2bvh-fixed.py

WORKDIR /
RUN wget https://www.denubila.com.br/downloads/blender.zip
RUN unzip -n blender.zip
RUN rm blender.zip

ENV BLENDER_PATH=/blender
RUN chmod -R 777 /blender

WORKDIR /usr/src/easymocap
