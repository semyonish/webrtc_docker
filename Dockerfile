FROM ubuntu:18.04
LABEL mail="sish@1c.ru"

COPY ./webrtc_build /webrtc_build

RUN apt-get update
RUN xargs apt-get -y install < webrtc_build/requirements.txt
RUN chmod +x /webrtc_build/*.sh

WORKDIR /webrtc_build