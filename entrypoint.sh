#!/bin/bash

source /root/emsdk/emsdk_env.sh --build=Release 

export EMSCRIPTEN=/root/emsdk/upstream/emscripten

exec "$@"
