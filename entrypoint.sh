#!/bin/bash

source /root/emsdk/emsdk_env.sh --build=Release 

exec "$@"
