#!/usr/bin/env bash

CWD=`pwd`

cd ../nodecg-io

ls -d nodecg-io-* | while read z; do
  echo "Create tarball for ${z}"
  cd ${z}
  if [[ ${z} == 'nodecg-io-core' ]]; then
    cp package.json package.json---tarball
    python3 ${CWD}/replace_json.py package.json
    tar --exclude 'node_modules' --exclude '*.js' --exclude 'package.json---tarball' --exclude 'dashboard' -czf ${CWD}/${z}.tar.gz .
    mv package.json---tarball package.json

    cd dashboard
    echo "Create tarball for nodecg-io-dashboard"
    cp package.json package.json---tarball
    python3 ${CWD}/replace_json.py package.json
    tar --exclude 'node_modules' --exclude '*.js' --exclude 'package.json---tarball' -czf ${CWD}/nodecg-io-dashboard.tar.gz .
    mv package.json---tarball package.json
    cd ..
  else
    cp package.json package.json---tarball
    python3 ${CWD}/replace_json.py package.json
    tar --exclude 'node_modules' --exclude '*.js' --exclude 'package.json---tarball' -czf ${CWD}/${z}.tar.gz .
    mv package.json---tarball package.json
  fi
  cd ..
done