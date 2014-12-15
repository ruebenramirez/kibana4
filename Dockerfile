FROM ubuntu:trusty
MAINTAINER Rueben Ramirez <ruebenramirez@gmail.com>

RUN sed -i 's/archive.ubuntu.com/mirror.rackspace.com/g' /etc/apt/sources.list

RUN sudo apt-get update
RUN sudo apt-get install -y openjdk-7-jre-headless vim screen wget curl

WORKDIR /opt

RUN wget --no-check-certificate -O- https://download.elasticsearch.org/kibana/kibana/kibana-4.0.0-BETA2.tar.gz | tar -xzvf -

RUN sed -i 's/elasticsearch: "http:\/\/localhost:9200\"/elasticsearch: \"http:\/\/elk.cdb.rax.io:9200\"/g' /opt/kibana-4.0.0-BETA2/config/kibana.yml

EXPOSE 5601

CMD ["/opt/kibana-4.0.0-BETA2/bin/kibana"]
