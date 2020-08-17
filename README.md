# CoreDNS

This is an implementation of CoreDNS (https://coredns.io). This image uses a non-priviledged user named "coredns".

Because this user is not privileged, the standard DNS port 53 cannot be used.

# Usage
```
docker run --rm -p 53:1053 -ti ybovard/coredns:latest
```

To test:

```
$ dig @localhost -p 53 whoami.example.org +tcp

; <<>> DiG 9.16.1-Ubuntu <<>> @localhost -p 53 whoami.example.org +tcp
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 60334
;; flags: qr aa rd; QUERY: 1, ANSWER: 0, AUTHORITY: 0, ADDITIONAL: 3
;; WARNING: recursion requested but not available

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
; COOKIE: ffdd43b0e437dad0 (echoed)
;; QUESTION SECTION:
;whoami.example.org.		IN	A

;; ADDITIONAL SECTION:
whoami.example.org.	0	IN	A	172.17.0.1
_tcp.whoami.example.org. 0	IN	SRV	0 0 57958 .

;; Query time: 4 msec
;; SERVER: 127.0.0.1#53(127.0.0.1)
;; WHEN: lun aoû 17 16:47:15 CEST 2020
;; MSG SIZE  rcvd: 135

$
```
