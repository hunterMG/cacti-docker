#name of container: cacti

FROM quantumobject/docker-baseimage:15.10
LABEL maintainer="vyg178@163.com"

ENV DEBIAN_FRONTEND=noninteractive
RUN echo "deb http://archive.ubuntu.com/ubuntu `cat /etc/container_environment/DISTRIB_CODENAME`-backports main restricted " >> /etc/apt/sources.list && \
    echo "deb http://archive.ubuntu.com/ubuntu/ `cat /etc/container_environment/DISTRIB_CODENAME` multiverse " >> /etc/apt/sources.list
RUN apt-get update && apt-get install -yq cacti \
                                          snmpd \
                                          cacti-spine \
                                          python-netsnmp \
                                          libnet-snmp-perl \
                                          snmp-mibs-downloader

EXPOSE 80 443 161

CMD ["/sbin/my_init"]