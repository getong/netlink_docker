netlink_docker
=====

An OTP application

Init the project
----
```
rebar3 new release netlink_docker
```
Then add `netlink` as dep in the rebar.config, and add the `netlink` to the `apps/netlink_docker/src/netlink_docker.app.src`.

Build
-----

```
    $ rebar3 compile
```

Build docker images
----

```
$ docker build -t netlink_docker:123456 -f dockerfile .
```

Run the docker container
----

```
$ cd script1
$ ./start.sh

$ cd ../script2
$ ./start.sh
```

Error message
----
After a few seconds, the second docker container fails

```
$ docker ps -a
3a252effb45c        netlink_docker:123456   "/netlink_docker/bin…"   4 minutes ago       Exited (1) 4 minutes ago                             netlink_test2
6d6ede26cdbf        netlink_docker:123456   "/netlink_docker/bin…"   4 minutes ago       Up 4 minutes                                         netlink_test1

$ docker logs netlink_test2
...
application: netlink
    exited: {{shutdown,
                 {failed_to_start_child,netlink,
                     {eaddrinuse,
                         [{erlang,open_port,
                              [{spawn_driver,"netlink_drv 0"},[binary]],
                              []},
                          {netlink,init_drv,2,
                              [{file,
                                   "/build_temp/_build/default/lib/netlink/src/netlink.erl"},
                               {line,207}]},
                          {gen_server,init_it,2,
                              [{file,"gen_server.erl"},{line,374}]},
                          {gen_server,init_it,6,
                              [{file,"gen_server.erl"},{line,342}]},
                          {proc_lib,init_p_do_apply,3,
                              [{file,"proc_lib.erl"},{line,249}]}]}}},
             {netlink_app,start,[normal,[]]}}
    type: permanent
Kernel pid terminated (application_controller) ({application_start_failure,netlink,{{shutdown,{failed_to_start_child,netlink,{eaddrinuse,[{erlang,open_port,[{spawn_driver,"netlink_drv 0"},[binary]],[]
...
```
