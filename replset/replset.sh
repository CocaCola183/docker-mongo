#!/bin/bash

# master
mongo $MONGO_MASTER:27017/admin --eval "rs.initiate({\"_id\": \"$MONGO_REPLSET_NAME\", \"members\": [{\"_id\": 0, \"host\": \"$MONGO_MASTER:27017\"}]});"

# secondary
hosts=$(echo $MONGO_SECONDARY | tr "," "\n")

for hst in $hosts
do
  mongo $MONGO_MASTER:27017/admin --eval "rs.add(\"$hst:27017\")";
done

# arbiter
arbiters=$(echo $MONGO_ARBITER | tr "," "\n")

for arbiter in $arbiters
do
  mongo $MONGO_MASTER:27017/admin --eval "rs.addArb(\"$arbiter:27017\")";
done