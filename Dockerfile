ARG COREDNS_VERSION=1.7.0

FROM golang:1.14.7-alpine3.12

ARG COREDNS_VERSION

RUN apk update ; apk upgrade ; apk add git make

WORKDIR /opt
RUN adduser -D --uid=1000 -h /home/coredns coredns
RUN git clone https://github.com/coredns/coredns.git ; chown -R coredns /opt/coredns

USER 1000
WORKDIR /opt/coredns
RUN git checkout tags/v${COREDNS_VERSION} ; make

USER root
RUN setcap cap_net_bind_service=+ep /opt/coredns \
  && setcap -v cap_net_bind_service=+ep /opt/coredns \
  && setcap cap_net_bind_service=+ep /opt/coredns/coredns \
  && setcap -v cap_net_bind_service=+ep /opt/coredns/coredns \

USER 1000
EXPOSE 1053/tcp 1053/tcp

ENTRYPOINT [ "/opt/coredns/coredns" ]
CMD [ "-dns.port" ,"1053" ]
