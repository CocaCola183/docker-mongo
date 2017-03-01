FROM mongo:3.3
MAINTAINER "kivi"

RUN mkdir -p /opt/mongo-replset-script
COPY ./replset.sh /opt/mongo-replset-script
WORKDIR /opt/mongo-replset-script
RUN chmod +x replset.sh

# CMD ["/bin/bash", "./replset.sh"]
# RUN /opt/mongo-replset-script/replset.sh

# docker build -t mongo-replset .