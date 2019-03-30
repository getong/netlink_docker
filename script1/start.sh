#!/bin/sh

docker run -d --network host -v $(pwd):/mnt/netlink_docker -e VMARGS_PATH="/mnt/netlink_docker/vm.args" --name netlink_test1 netlink_docker:123456
