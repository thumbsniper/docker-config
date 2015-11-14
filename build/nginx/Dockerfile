FROM opensuse:13.2

MAINTAINER Thomas Schulte <thomas@cupracer.de>

RUN zypper --non-interactive ref && zypper --non-interactive in curl

RUN rpm --import http://download.opensuse.org/repositories/server:/http/openSUSE_13.2/repodata/repomd.xml.key

RUN /usr/bin/zypper ar --refresh http://download.opensuse.org/repositories/server:/http/openSUSE_13.2/server:http.repo

RUN /usr/sbin/groupadd -g 999 nginx
RUN /usr/sbin/useradd -u 999 -g 999 -c "docker user" -m nginx

RUN zypper --non-interactive ref && zypper --non-interactive in	nginx

RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

