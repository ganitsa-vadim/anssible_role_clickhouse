FROM debian:bookworm

ENV container docker

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y apt-transport-https gnupg2 python3-minimal python3-apt man systemd systemd-sysv rsyslog sudo bash ca-certificates iproute2 \
    && apt-get clean

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
    systemd-tmpfiles-setup.service ] || rm -f $i; done); \
    rm -rf /lib/systemd/system/multi-user.target.wants/*;\
    rm -rf /etc/systemd/system/*.wants/*;\
    rm -rf /lib/systemd/system/local-fs.target.wants/*; \
    rm -rf /lib/systemd/system/sockets.target.wants/*udev*; \
    rm -rf /lib/systemd/system/sockets.target.wants/*initctl*; \
    rm -rf /lib/systemd/system/basic.target.wants/*;\
    rm -rf /lib/systemd/system/anaconda.target.wants/*;
    # systemctl enable dbus.socket; \
    # systemctl enable dbus.service; \
    # systemctl enable rsyslog.service

VOLUME [ "/sys/fs/cgroup" ]
CMD ["/sbin/init"]