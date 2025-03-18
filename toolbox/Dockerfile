FROM ubuntu:latest

RUN apt update && apt install -y netcat-traditional tcpdump iputils-ping curl socat

EXPOSE 8125
EXPOSE 8126

# ENTRYPOINT [ "nc", "-ulk", "8125" ]
ENTRYPOINT [ "socat" ]
CMD [ "-u", "-d", "UDP-RECVFROM:8125,reuseaddr,fork", "STDOUT" ]
