FROM ubuntu:20.04
USER root

ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update
RUN apt-get -y install locales 
RUN localedef -f UTF-8 -i ja_JP ja_JP.UTF-8

ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8
ENV TZ JST-9
ENV TERM xterm

# WORK
RUN mkdir -p /root/tmp
WORKDIR /root/tmp

# python
RUN apt-get install -y vim less
RUN apt-get install -y sqlite3
RUN apt-get install -y python3 python3-pip

COPY requirements.txt /root/tmp
RUN pip install --upgrade pip
RUN pip install --upgrade setuptools
RUN pip install -r ./requirements.txt

# docker
COPY install_docker.sh /root/tmp/
RUN sh ./install_docker.sh