FROM ubuntu:xenial

ARG VERSION=1.38.48

SHELL ["/bin/bash", "-c"]

RUN apt-get update \
  && apt-get install -y git python cmake build-essential openjdk-9-jre-headless \
  && git clone --single-branch --branch master --depth 1 https://github.com/juj/emsdk.git /root/emsdk \
  && cd /root \ 
	&& /root/emsdk/emsdk install ${VERSION} \
	&& /root/emsdk/emsdk activate ${VERSION} \
  && source /root/emsdk/emsdk_env.sh --build=Release  \
  && emcc -v

WORKDIR /app

COPY ./entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]

CMD ["emcc"]
