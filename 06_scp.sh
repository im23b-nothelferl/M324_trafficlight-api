#!/bin/bash
#
# Copies the app, the scripts and the tests to your AWS EC2 instance.
# Usage: ./06_scp.sh <public-DNS-of-your-EC2-instance> <path-to-private-key.pem>
#
# Set variable for target node (your AWS EC2 instance)
node="ubuntu@${1:?Provide the public DNS of your EC2 instance as 1st argument}"
# Set variable for target directory where the app should be stored
target="~/trafficlight-api"
# Set private key
key="$2"
# check if private key is set
if [ -z "${key}" ] || [ ! -f "${key}" ]; then
  echo "Error: private key not found. Provide it as 2nd argument. Exit script."
  exit 1
fi
# remove (with ssh) target directory for the app
ssh -i "${key}" "${node}" "rm -rf ${target}"
# create (with ssh) target directory for the app
ssh -i "${key}" "${node}" "mkdir -p ${target}"
# copy (with scp) all bash script to destination
scp -i "${key}" ./*.sh "${node}:${target}/"
# copy (with scp) the backend to destination
scp -i "${key}" -r ./backend "${node}:${target}/"
# copy (with scp) dockerfile to destination
scp -i "${key}" ./Dockerfile ./.dockerignore "${node}:${target}/"
# copy (with scp) unit testing files to destination
ssh -i "${key}" "${node}" "mkdir -p ${target}/client"
scp -i "${key}" ./client/package.json ./client/trafficlight.test.js "${node}:${target}/client/"
echo "copied to ${node}:${target}"
