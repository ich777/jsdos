FROM ubuntu

MAINTAINER ich777

RUN apt-get update
RUN apt-get -y install wget curl
RUN curl -sL https://deb.nodesource.com/setup_13.x | bash -
RUN apt-get -y install nodejs

ENV SERVER_DIR=/jsdos
ENV UMASK=000
ENV UID=99
ENV GID=100

RUN mkdir $SERVER_DIR
RUN useradd -d $SERVER_DIR -s /bin/bash --uid $UID --gid $GID jsdos
RUN chown -R jsdos $SERVER_DIR

RUN ulimit -n 2048

ADD /scripts/ /opt/scripts/
RUN chmod -R 770 /opt/scripts/
RUN chown -R jsdos /opt/scripts/

USER jsdos

#Server Start
ENTRYPOINT ["/opt/scripts/start-server.sh"]