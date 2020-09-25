FROM ubuntu:xenial

SHELL ["/bin/bash", "-c"]

RUN apt-get update \
  && apt-get install -y git python3 python3-pip cmake build-essential openjdk-9-jre-headless \
  && pip3 install requests
  && git clone --single-branch --branch master --depth 1 https://github.com/juj/emsdk.git /root/emsdk \
  && cd /root \ 
	&& /root/emsdk/emsdk install latest \
	&& /root/emsdk/emsdk activate latest \
  && source /root/emsdk/emsdk_env.sh --build=Release  \
  && emcc -v

WORKDIR /app

COPY ./entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]

CMD ["emcc"]
