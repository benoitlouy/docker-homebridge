FROM resin/rpi-raspbian:jessie
MAINTAINER Benoit Louy <benoit.louy@fastmail.com>

VOLUME /config

RUN apt-get update
RUN apt-get -y upgrade 

RUN apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -

RUN apt-get install -y g++ git make nodejs libavahi-compat-libdnssd-dev avahi-daemon avahi-discover

RUN npm install -g --unsafe-perm homebridge hap-nodejs node-gyp
RUN cd /usr/lib/node_modules/homebridge && \
    npm install --unsafe-perm bignum
RUN cd /usr/lib/node_modules/hap-nodejs/node_modules/mdns && \
    node-gyp BUILDTYPE=Release rebuild
RUN npm install -g homebridge-homeassistant

RUN mkdir -p /var/run/dbus
ADD run.sh /root/run.sh

CMD [ "/root/run.sh" ]
