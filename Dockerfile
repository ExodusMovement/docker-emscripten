FROM ubuntu:xenial

ARG COMMIT=7f9af7bd1af0b4c90abe9fce1b7c32566c0722f6
ARG VERSION=1.38.48

SHELL ["/bin/bash", "-c"]

RUN apt-get update \
  && apt-get install -y git python cmake build-essential openjdk-9-jre-headless \
  && git clone --single-branch --branch "$VERSION" --depth 1 https://github.com/juj/emsdk.git /root/emsdk \
  && cd /root/emsdk \
  && git checkout "$COMMIT" \
  && /root/emsdk/emsdk install ${VERSION} \
  && /root/emsdk/emsdk activate ${VERSION} \
  && source /root/emsdk/emsdk_env.sh --build=Release  \
  && emcc -v

WORKDIR /app

COPY ./entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]

CMD ["emcc"]
