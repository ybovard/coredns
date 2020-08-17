FROM golang:1.14.7-alpine3.12

RUN apk update ; apk upgrade ; apk add git make

WORKDIR /opt
RUN adduser -D -h /home/coredns coredns
RUN git clone https://github.com/coredns/coredns.git ; chown -R coredns /opt/coredns
USER coredns
RUN cd /opt/coredns ; make

EXPOSE 1053/tcp 1053/tcp

ENTRYPOINT [ "/opt/coredns/coredns" ]
CMD [ "-dns.port" ,"1053" ]
