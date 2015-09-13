# dockerfiles-freeipa-client-ssh-server

This repository contains Docker files for building a Docker image with a FreeIPA client and an OpenSSH server.

To build the image, run:

```
$ sudo docker build --rm -t tscholak/freeipa-client-ssh-server .
```

To pull the image from Docker Hub, run:

```
$ sudo docker pull tscholak/freeipa-client-ssh-server
```

To run a container called `fcss` from the image, execute:

```
$ sudo docker run -d --name=fcss \
  --privileged=false --cap-add SYS_TIME \
  --net=none --hostname=fcss.[YOUR IPA DOMAIN] \
  -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
	tscholak/freeipa-client-ssh-server
```

where `[YOUR IPA DOMAIN]` is your FreeIPA domain.

You should read [this blog post](http://tscholak.github.io/docker/mongodb/freeipa/2015/09/13/freeipa-client-ssh-server.html) to learn about the configuration.