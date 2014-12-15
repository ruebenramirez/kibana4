#!/bin/bash

docker rm -f kibana4
docker build -t kibana4 .
docker run -d -p 5601:5601 --name kibana4 kibana4 
