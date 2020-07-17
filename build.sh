#!/usr/bin/env bash

CWD=`pwd`

cd ../nodecg-io

git show -s --format=' Current status %n----------------%n%n%h   %H%n%cD by %an%n%n%s%n%b' > ${CWD}/STATUS

echo -e "\033[0;35m\033[1mCall \`npm install\`\033[0m"
npm install

echo -e "\033[0;35m\033[1mCall \`npm run build\`\033[0m"
npm run build

ls -d nodecg-io-* | while read z; do
  echo -e "\033[1;34m\033[1mCreate tarball for ${z}\033[0m"
  cd ${z}
  if [[ ${z} == 'nodecg-io-core' ]]; then
    cp package.json package.json---tarball
    python3 ${CWD}/replace_json.py package.json
    tar --exclude 'node_modules' --exclude 'package.json---tarball' --exclude 'dashboard' -czf ${CWD}/${z}.tar.gz .
    mv package.json---tarball package.json

    cd dashboard
    echo -e "\033[1;34m\033[1mCreate tarball for nodecg-io-dashboard\033[0m"
    cp package.json package.json---tarball
    python3 ${CWD}/replace_json.py package.json
    tar --exclude 'node_modules' --exclude 'package.json---tarball' -czf ${CWD}/nodecg-io-dashboard.tar.gz .
    mv package.json---tarball package.json
    cd ..
  else
    cp package.json package.json---tarball
    python3 ${CWD}/replace_json.py package.json
    tar --exclude 'node_modules' --exclude 'package.json---tarball' -czf ${CWD}/${z}.tar.gz .
    mv package.json---tarball package.json
  fi
  cd ..
done

echo -e "\033[0;35m\033[1mDone\033[0m"