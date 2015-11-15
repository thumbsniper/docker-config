FROM mongo:latest

MAINTAINER Thomas Schulte <thomas@cupracer.de>

RUN apt-get update && apt-get install -y \
	netcat

COPY init.sh /

CMD ["/init.sh"]

