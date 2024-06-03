#!/bin/bash
set -e

MODE="${1:-null}"

if [ "${MODE}" = 'ssh' ]; then
    /usr/sbin/sshd -p 9000
elif [ "${MODE}" = 'tornado' ]; then
    nohup python /workspace/main.py 9000 ${@:2} >> /workspace/log.out 2>&1 &
elif [ "${MODE}" = 'fastapi' ]; then
    nohup uvicorn main:app --host 0.0.0.0 --port 9000 --workers 1 >> /workspace/log.out 2>&1 &
elif [ "${MODE}" = 'notebook' ]; then
    nohup jupyter notebook --ip='*' --port=9000 --notebook-dir='/workspace' --NotebookApp.token='hi' --no-browser --allow-root >> /workspace/log.out 2>&1 &
fi

tail -f /dev/null