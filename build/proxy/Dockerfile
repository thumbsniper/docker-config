FROM opensuse:13.2

MAINTAINER Thomas Schulte <thomas@cupracer.de>

EXPOSE 80
CMD [ "/usr/sbin/varnishd", "-F", "-f", "/etc/varnish/vcl.conf", "-T127.0.0.1:6082", "-s", "file,/var/cache/varnish,2G", "-u", "varnish" ]

RUN /usr/sbin/groupadd -g 999 varnish
RUN /usr/sbin/useradd -u 999 -g 999 -c varnish -d /var/lib/varnish -s /bin/false varnish

RUN zypper --non-interactive ref && zypper --non-interactive in varnish

COPY etc/varnish /etc/varnish

RUN zypper --non-interactive up

