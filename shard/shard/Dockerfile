FROM mongo:3.3
MAINTAINER "kivi"

RUN apt-get update && apt-get install -y wget
ENV DOCKERIZE_VERSION v0.2.0
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

RUN mkdir -p /opt/mongo-shard-script
COPY ./shard.sh /opt/mongo-shard-script
WORKDIR /opt/mongo-shard-script
RUN chmod +x shard.sh

# CMD ["/bin/bash", "./shard.sh"]

# docker build -t mongo-shard .