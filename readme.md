# Containers

## flystarhe/python

* `3.8`, `3.8-torch`, `3.8-torch1.7.0`

## flystarhe/simplecv

* `mmdet2.6`, `mmdet2.7`
* `yolo5.3.1`

## build and run
```
export DOCKER_BUILDKIT=1
docker build -t flystarhe/simplecv:mmdet2.7 -f mmdet2.7 .
docker build -t flystarhe/python:3.8 -f 3.8 --target official .
docker build -t flystarhe/python:3.8-torch -f 3.8-torch --target official .

docker run -it --rm --gpus device=0,1 nvidia/cuda:11.1-base-ubuntu18.04 bash
docker run -d -p 9000:9000 -p 9001:9001 --ipc=host --name test -v "$(pwd)":/workspace flystarhe/python:3.8
docker run --gpus all -d -p 9000:9000 -p 9001:9001 --ipc=host --name test -v "$(pwd)":/workspace flystarhe/python:3.8-torch

docker exec -it CONTAINER_NAME bash
```

* Jupyter [http://ip:9000/?token=hi](http://ip:9000/?token=hi)
* `/usr/sbin/sshd -p 9001` for `dev` mode
* `python /workspace/app_tornado.py 9001 ${@:2}` for `app` mode

## app
```python
import requests

url = "http://ip:9001/main"
vals = {"image": "/workspace/test.png"}

response = requests.get(url, params=vals)
print(response.status_code)
print(response.text)
```
