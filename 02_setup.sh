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
# Build a dockerfile
echo "build image"
docker build -f "${file}" -t "${image}" .
# List images
docker images "${image}"
