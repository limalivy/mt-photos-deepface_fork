#!/bin/bash

export LD_PRELOAD="$(find /usr/local/lib/python3.8/site-packages/torch.libs -type f -name 'libgomp*')"
echo $LD_PRELOAD
python3 server.py