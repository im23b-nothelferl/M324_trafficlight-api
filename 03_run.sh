#!/usr/bin/bash
# Attention:
# Change CRLF (Windows) to LF (Unix on AWS) in your Editor
#
# Set variable PARAMS
PARAMS="./01_params.sh"
# check if PARAMS is set else exit
if [ ! -f "${PARAMS}" ]; then
  echo "Error: ${PARAMS} not found. Exit script."
  exit 1
fi
# import PARAMS
source "${PARAMS}"
# run image
echo "run now container $container"
# remove an old container with the same name first (ignore error if there is none)
docker rm -f "${container}" > /dev/null 2>&1
docker run -d --name "${container}" -p 3000:3000 "${image}"
