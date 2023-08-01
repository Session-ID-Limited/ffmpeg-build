#!/bin/sh
set -e

docker-buildx build -t ffmpeg-al2 .
docker run -td --name ffmpeg-al2 --rm --entrypoint bash ffmpeg-al2
TEMP_DIR=$(mktemp -d)
docker cp ffmpeg-al2:/usr/local/bin ${TEMP_DIR}/bin
docker cp ffmpeg-al2:/usr/local/lib64 ${TEMP_DIR}/lib
docker stop ffmpeg-al2
rm -f ./ffmpeg-lambda-layer.zip
DIR=$(pwd)
cd ${TEMP_DIR}
zip -r ${DIR}/ffmpeg-lambda-layer.zip *
cd ${DIR}
rm -rf ${TEMP_DIR}
