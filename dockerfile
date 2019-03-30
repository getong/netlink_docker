FROM erlang:21.3.2-alpine as builder

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN apk update
RUN apk add ca-certificates openssl git gcc musl-dev g++ make tzdata wget linux-headers

RUN mkdir /build_temp

WORKDIR /build_temp

COPY . .

RUN rebar3 update

RUN rebar3 as prod tar

RUN mkdir -p /opt/rel

RUN tar xzf _build/prod/rel/*/*.tar.gz -C /opt/rel

FROM erlang:21.3.2-alpine

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories
RUN apk update
RUN apk add openssl musl-dev g++ tzdata

RUN mkdir /netlink_docker
WORKDIR /netlink_docker

COPY --from=builder /opt/rel .

CMD ["/netlink_docker/bin/netlink_docker", "foreground"]
