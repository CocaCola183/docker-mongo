FROM mongo:3.3
MAINTAINER "kivi"

RUN mkdir -p /opt/mongo-replset-script
COPY ./replset.sh /opt/mongo-replset-script
WORKDIR /opt/mongo-replset-script
RUN chmod +x replset.sh

ENV MONGO_REPLSET_NAME=shard1
ENV MONGO_MASTER=mongo1-1
ENV MONGO_SECONDARY=mongo1-2
ENV MONGO_ARBITER=mongo1-3

CMD ["/bin/bash", "./replset.sh"]
# RUN /opt/mongo-replset-script/replset.sh

# docker build -t kivi/mongo-replset-confi:latest . #
