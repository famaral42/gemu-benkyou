FROM python:3.12.12-slim-trixie

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update && \
    apt-get -y upgrade && \
    python -m pip install --upgrade pip

RUN apt-get install -y \
    mesa-utils \
    nodejs \
    npm \
    ffmpeg \
    git \
    vim

RUN npm -g i love.js

RUN pip install --no-cache-dir \
    'black==25.9' \
    'numpy==2.3.3 ' \
    'pygame-ce==2.5.5' \
    'pygbag==0.9.2' \
    'pyopengl==3.1.10'
