#name of container: cacti

FROM quantumobject/docker-baseimage:15.10
LABEL maintainer="vyg178@163.com"

RUN echo "deb http://mirrors.aliyun.com/ubuntu/ `cat /etc/container_environment/DISTRIB_CODENAME`-backports main restricted " >> /etc/apt/sources.list && \
    echo "deb http://mirrors.aliyun.com/ubuntu/ `cat /etc/container_environment/DISTRIB_CODENAME` multiverse " >> /etc/apt/sources.list
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -yq cacti \
                                          snmpd \
                                          cacti-spine \
                                          python-netsnmp \
                                          libnet-snmp-perl \
                                          snmp-mibs-downloader \
                   && rm -rf 

EXPOSE 80 443 161

CMD ["/sbin/my_init"]