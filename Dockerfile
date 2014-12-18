FROM ubuntu:trusty
MAINTAINER Rueben Ramirez <ruebenramirez@gmail.com>

RUN sed -i 's/archive.ubuntu.com/mirror.rackspace.com/g' /etc/apt/sources.list

RUN sudo apt-get update
RUN sudo apt-get install -y openjdk-7-jre-headless vim screen wget curl git

WORKDIR /opt

### install the base kibana 4 beta release
RUN wget --no-check-certificate -O- https://download.elasticsearch.org/kibana/kibana/kibana-4.0.0-beta3.tar.gz | tar -xzvf -

### bring in the plugins from the kibana4 beta 3 tag
RUN git clone http://github.com/elasticsearch/kibana.git
WORKDIR /opt/kibana/
RUN git checkout -b v4.0.0-beta3 tags/v4.0.0-beta3
WORKDIR /opt/kibana-4.0.0-beta3/src/kibana/plugins
RUN cp -R /opt/kibana/src/kibana/plugins/* .

### config Kibana to connect to elk.cdb elasticsearch
RUN sed -i 's/elasticsearch: "http:\/\/localhost:9200\"/elasticsearch: \"http:\/\/elk.cdb.rax.io:9200\"/g' /opt/kibana-4.0.0-beta3/config/kibana.yml

EXPOSE 5601

CMD ["/opt/kibana-4.0.0-beta3/bin/kibana"]
