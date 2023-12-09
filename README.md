# Containers

## registry.cn-hangzhou.aliyuncs.com/flystarhe/containers

* [https://cr.console.aliyun.com/cn-hangzhou/instance/repositories](https://cr.console.aliyun.com/cn-hangzhou/instance/repositories)
* `docker pull registry.cn-hangzhou.aliyuncs.com/flystarhe/containers:[镜像版本号]`

## flystarhe/mmdet

* [https://hub.docker.com/repository/docker/flystarhe/mmdet](https://hub.docker.com/repository/docker/flystarhe/mmdet)
* `docker pull flystarhe/mmdet:[镜像版本号]`

`mmdet/v2.25.1`

>Run `python mmdet/utils/collect_env.py` to check built environment.

## flystarhe/torch

* [https://hub.docker.com/repository/docker/flystarhe/torch](https://hub.docker.com/repository/docker/flystarhe/torch)
* `docker pull flystarhe/torch:[镜像版本号]`

`1.8.1-cuda11.1-dev`

>CUDA HOME `from torch.utils.cpp_extension import CUDA_HOME`, CUDA architectures with `torch.cuda.get_arch_list()`, NVCC gencode flags with `torch.cuda.get_gencode_flags()`.

## flystarhe/yolov5

* [https://hub.docker.com/repository/docker/flystarhe/yolov5](https://hub.docker.com/repository/docker/flystarhe/yolov5)
* `docker pull flystarhe/yolov5:[镜像版本号]`

`v6.1-torch1.12-cuda11.3`

## build and run
```
docker save -o mmdet2.8-21.02.tar mmdet:2.8
docker load -i mmdet2.8-21.02.tar

docker images registry.cn-hangzhou.aliyuncs.com/flystarhe/containers
docker images registry.cn-hangzhou.aliyuncs.com/flystarhe/containers:mmdet*
docker images --filter=reference='*/*/*:mmdet*'

docker build -t flystarhe/python:3.8 -f 3.8 .

export DOCKER_BUILDKIT=1
docker build -t flystarhe/python:3.8 -f 3.8 --target official .

docker run -it --rm --gpus all nvidia/cuda:11.1-base-ubuntu18.04 bash
t=test && docker run -d -p 7000:9000 -p 7001:9001 --ipc=host --name ${t} -v "$(pwd)"/${t}:/workspace flystarhe/python:3.8
t=test && docker run --gpus '"device=0,1"' -d -p 7000:9000 -p 7001:9001 --ipc=host --name ${t} -v "$(pwd)"/${t}:/workspace flystarhe/python:3.8
```

* `/usr/sbin/sshd -D -p 7000` for `ssh` mode
* `python /workspace/app_tornado.py 7000 ${@:2}` for `app` mode
* `http://ip:7000/?token=hi` for `notebook` mode or other command

## docker hub
```
docker login -u flystarhe
docker tag local-image:tagname new-repo:tagname
docker push new-repo:tagname
docker logout
```

## test app
```python
import requests

url = "http://ip:7000/main"
vals = {"image": "/workspace/test.png"}

response = requests.get(url, params=vals)
print(response.status_code)
print(response.text)

response = requests.post(url, data=vals)
print(response.status_code)
print(response.json())
```

## notes
```
# apt-get install -y openssh-server
# RUN mkdir -p /run/sshd && mkdir -p ~/.ssh && echo "# ssh keys" > ~/.ssh/authorized_keys

# sed -i 's/http:\/\/archive.ubuntu.com/https:\/\/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list
# conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/pytorch
# conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main
# rm -rf /etc/apt/sources.list.d/cuda.list /etc/apt/sources.list.d/nvidia-ml.list
# pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
# https://mirrors.tuna.tsinghua.edu.cn/help/anaconda/
```

timezone
```Dockerfile
FROM ubuntu

# 设置localtime
# 此处需要优先设置localtime，否则安装tzdata将会进入时区选择
RUN ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# 安装tzdata
RUN apt-get update && apt-get install -y tzdata
```
