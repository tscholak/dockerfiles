#!/bin/bash

: ${ROOT_PASS:=$(dd if=/dev/urandom bs=1 count=15 | base64)}

__set_root_pass() {
	echo "$ROOT_PASS" | (passwd --stdin root)
	echo root password: $ROOT_PASS
}

__enable_ntpd() {
	systemctl enable ntpd.service
}

__enable_sshd() {
	systemctl enable sshd.service
}

__set_root_pass
__start_ntpd
__start_sshd

exec "$@"