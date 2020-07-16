#!/usr/bin/env python3

import sys
import json

with open(sys.argv[1], mode='r') as file:
    data = json.loads(file.read())

if 'dependencies' in data:
    for key in data['dependencies']:
        if key.startswith('nodecg-io-'):
            data['dependencies'][key] = f'https://raw.githubusercontent.com/noeppi-noeppi/nodecg-io-tarballs/master/{key}.tar.gz'

if 'devDependencies' in data:
    for key in data['devDependencies']:
        if key.startswith('nodecg-io-'):
            data['devDependencies'][key] = f'https://raw.githubusercontent.com/noeppi-noeppi/nodecg-io-tarballs/master/{key}.tar.gz'

with open(sys.argv[1], mode='w') as file:
    file.write(json.dumps(data))