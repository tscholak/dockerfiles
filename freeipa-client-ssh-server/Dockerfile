FROM fedora:22
MAINTAINER Torsten Scholak "tscholak@googlemail.com"

EXPOSE 22

RUN dnf clean expire-cache; dnf -yv update; dnf clean all

RUN dnf -yv --allowerasing install systemd; dnf clean all; \
	(cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
	rm -f /lib/systemd/system/multi-user.target.wants/*;\
	rm -f /etc/systemd/system/*.wants/*;\
	rm -f /lib/systemd/system/local-fs.target.wants/*; \
	rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
	rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
	rm -f /lib/systemd/system/basic.target.wants/*;\
	rm -f /lib/systemd/system/anaconda.target.wants/*;
RUN systemctl mask systemd-remount-fs.service dev-hugepages.mount \
  sys-fs-fuse-connections.mount systemd-logind.service getty.target \
  console-getty.service dnf-makecache.service

RUN cp /usr/lib/systemd/system/dbus.service /etc/systemd/system/; \
  sed -i 's/OOMScoreAdjust=-900//' /etc/systemd/system/dbus.service
RUN systemctl enable dbus.service

RUN dnf -yv install \
  passwd \
  openssh-clients openssh-server initscripts \
	freeipa-client \
	python-dbus; dnf clean all

RUN mv /usr/bin/domainname /usr/bin/domainname.bak
RUN echo -e '#!/bin/sh\nexit 0' > /usr/bin/domainname
RUN chmod +x /usr/bin/domainname

RUN systemctl enable ntpd.service

RUN echo "UseDNS no" >> /etc/ssh/sshd_config
RUN sed -i 's/UsePrivilegeSeparation sandbox/UsePrivilegeSeparation no/' /etc/ssh/sshd_config

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

VOLUME ["/sys/fs/cgroup"]
VOLUME ["/run"]

CMD  ["/usr/lib/systemd/systemd"]