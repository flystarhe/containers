#!/bin/bash
set -e

MODE=${1:-dev}
if [ "${MODE}" = 'dev' ]; then
    /usr/sbin/sshd -p 9001
else
    nohup python /workspace/app_tornado.py 9001 ${@:2} > /workspace/nohup.out 2>&1 &
fi

jupyter notebook --ip='*' --port=9000 --notebook-dir='/workspace' --NotebookApp.token='hi' --no-browser --allow-root