#name of container: cacti

FROM quantumobject/docker-baseimage:15.10
LABEL maintainer="vyg178@163.com"

RUN echo "http://cn.archive.ubuntu.com/ubuntu/ `cat /etc/container_environment/DISTRIB_CODENAME`-backports main restricted " >> /etc/apt/sources.list && \
    echo "http://cn.archive.ubuntu.com/ubuntu/ `cat /etc/container_environment/DISTRIB_CODENAME` multiverse " >> /etc/apt/sources.list
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -yq cacti \
                                          snmpd \
                                          cacti-spine \
                                          python-netsnmp \
                                          libnet-snmp-perl \
                                          snmp-mibs-downloader \
    && apt-get clean \
    && rm -rf /tmp/* /var/tmp/*  \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 80 443 161

CMD ["/sbin/my_init"]