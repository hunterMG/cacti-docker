#name of container: cacti

FROM quantumobject/docker-baseimage:15.10
LABEL maintainer="vyg178@163.com"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -yq cacti \
                                          snmpd \
                                          cacti-spine \
                                          python-netsnmp \
                                          libnet-snmp-perl \
                                          snmp-mibs-downloader

EXPOSE 80 443 161

CMD ["/sbin/my_init"]