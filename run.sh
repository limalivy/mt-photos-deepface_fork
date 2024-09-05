#!/bin/bash


FILE_PATH=$(find /usr/local/lib/python3.8/site-packages/torch.libs -type f -name "libgomp*" 2>/dev/null)
if [[ -n $FILE_PATH ]]; then
    # 文件存在，export该路径
    export LD_PRELOAD=$FILE_PATH
    echo "File found at: $LD_PRELOAD"
else
    echo "File not found."
fi
python3 server.py