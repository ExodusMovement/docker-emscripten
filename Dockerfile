FROM ubuntu:xenial

ARG TAG=3.1.44
ARG COMMIT=a896e3d066448b3530dbcaa48869fafefd738f57
ARG VERSION=1.38.48

SHELL ["/bin/bash", "-c"]

RUN apt-get update \
  && apt-get install -y git python cmake build-essential openjdk-9-jre-headless \
  && git clone --single-branch --branch "$TAG" --depth 1 https://github.com/juj/emsdk.git /root/emsdk \
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
