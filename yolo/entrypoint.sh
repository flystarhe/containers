#!/bin/bash
set -e

MODE=${1:-dev}
if [ "${MODE}" = 'ssh' ]
then
    /usr/sbin/sshd -D -p 9000
elif [ "${MODE}" = 'app' ]
then
    nohup python /workspace/app_tornado.py 9000 ${@:2} > /workspace/nohup.out 2>&1
else
    jupyter notebook --ip='*' --port=9000 --notebook-dir='/workspace' --NotebookApp.token='hi' --no-browser --allow-root
fi
