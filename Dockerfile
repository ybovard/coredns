ARG COREDNS_VERSION=1.7.0

FROM golang:1.14.7-alpine3.12

ARG COREDNS_VERSION

RUN apk update ; apk upgrade ; apk add git make

WORKDIR /opt
RUN adduser -D -h /home/coredns coredns
RUN git clone https://github.com/coredns/coredns.git ; chown -R coredns /opt/coredns

USER coredns
WORKDIR /opt/coredns
RUN git checkout tags/v${COREDNS_VERSION} ; make

EXPOSE 1053/tcp 1053/tcp

ENTRYPOINT [ "/opt/coredns/coredns" ]
CMD [ "-dns.port" ,"1053" ]
