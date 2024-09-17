FROM ubuntu:latest

RUN apt update && apt install -y netcat-traditional tcpdump iputils-ping curl

CMD [ "nc", "-ul", "-p8126" ]
