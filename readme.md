# Containers

## registry.cn-hangzhou.aliyuncs.com/flystarhe/containers

* [https://cr.console.aliyun.com/cn-hangzhou/instance/repositories](#)
* `docker pull registry.cn-hangzhou.aliyuncs.com/flystarhe/containers:[镜像版本号]`

`mmdet2.7`, `mmdet2.8`, `yolo5.3.1`

## flystarhe/python

* [https://hub.docker.com/repository/docker/flystarhe/python](#)
* `docker pull flystarhe/python:[镜像版本号]`

`3.8`, `3.8-torch`, `3.8-torch1.7.0`

## build and run
```
export DOCKER_BUILDKIT=1
docker build -t flystarhe/python:3.8 -f 3.8 --target official .
docker build -t flystarhe/python:3.8-torch -f 3.8-torch --target official .

docker run -it --rm --gpus all nvidia/cuda:11.1-base-ubuntu18.04 bash
t=test && docker run -d -p 9000:9000 --ipc=host --name ${t} -v "$(pwd)"/${t}:/workspace flystarhe/python:3.8
t=test && docker run --gpus device=0,1 -d -p 9000:9000 --ipc=host --name ${t} -v "$(pwd)"/${t}:/workspace flystarhe/python:3.8-torch
```

* [http://ip:9000/?token=hi](#) for `dev`
* `/usr/sbin/sshd -D -p 9000` for `ssh` mode
* `python /workspace/app_tornado.py 9000 ${@:2}` for `app` mode

## app
```python
import requests

url = "http://ip:9000/main"
vals = {"image": "/workspace/test.png"}

response = requests.get(url, params=vals)
print(response.status_code)
print(response.text)

response = requests.post(url, data=vals)
print(response.status_code)
print(response.json())
```
