#!/bin/bash

# -m PRIMARY节点的ip:port
# -s SECONDARY节点的ip:port
# -a ARBITER节点的ip:port
# -r replset名称

MASTER_ADDRESS=
SLAVE_ADDRESS=
ARBITER_ADDRESS=
SETNAME=

while getopts ":qvm:s:a:r:" OPTION 
do 
    case "$OPTION" in 
    "q") 
        echo "quiet" 
        ;; 
    "v") 
        echo "verbose" 
        ;; 
    "m") 
        # echo "Option $OPTION has value $OPTARG"
        MASTER_ADDRESS=$OPTARG
        ;; 
    "s") 
        # echo "Option $OPTION has value $OPTARG" 
        SLAVE_ADDRESS=$OPTARG
        ;; 
    "a") 
        # echo "Option $OPTION has value $OPTARG" 
        ARBITER_ADDRESS=$OPTARG
        ;; 
    "r") 
        # echo "Option $OPTION has value $OPTARG" 
        SETNAME=$OPTARG
        ;;
    "?") 
        echo "Unknown option $OPTARG" 
        ;; 
    ":") 
        echo "No argument value for option $OPTARG" 
        ;; 
    *) 
        # Should not occur 
        echo "Unknown error while processing options" 
        ;; 
    esac 
done

mongo $MASTER_ADDRESS/admin --eval "rs.initiate({\"_id\": \"$SETNAME\", \"members\": [{\"_id\": 0, \"host\": \"$MASTER_ADDRESS\"}]});"

# secondary
hosts=$(echo $SLAVE_ADDRESS | tr "," "\n")

for hst in $hosts
do
  mongo $MASTER_ADDRESS/admin --eval "rs.add(\"$hst\")";
done

# arbiter
arbiters=$(echo $ARBITER_ADDRESS | tr "," "\n")

for arbiter in $arbiters
do
  mongo $MASTER_ADDRESS/admin --eval "rs.addArb(\"$arbiter\")";
done