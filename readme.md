# Containers

## registry.cn-hangzhou.aliyuncs.com/flystarhe/containers

* [https://cr.console.aliyun.com/cn-hangzhou/instance/repositories](https://cr.console.aliyun.com/cn-hangzhou/instance/repositories)
* `docker pull registry.cn-hangzhou.aliyuncs.com/flystarhe/containers:[镜像版本号]`

mmdet: `2.10-mmcv1.2-torch1.7-cuda10.2`, `2.10-mmcv1.2-torch1.7-cuda11.0`, `2.10-mmcv1.2-torch1.8-cuda10.2`, `2.10-mmcv1.2-torch1.8-cuda11.1`

torch: `1.8.1-cuda10.2-dev`, `1.8.1-cuda11.1-dev`

## flystarhe/mmdet

* [https://hub.docker.com/repository/docker/flystarhe/mmdet](https://hub.docker.com/repository/docker/flystarhe/mmdet)
* `docker pull flystarhe/mmdet:[镜像版本号]`

`2.10-mmcv1.2-torch1.7-cuda10.2`, `2.10-mmcv1.2-torch1.7-cuda11.0`, `2.10-mmcv1.2-torch1.8-cuda10.2`, `2.10-mmcv1.2-torch1.8-cuda11.1`

>Run `python mmdet/utils/collect_env.py` to check built environment.

## flystarhe/torch

* [https://hub.docker.com/repository/docker/flystarhe/torch](https://hub.docker.com/repository/docker/flystarhe/torch)
* `docker pull flystarhe/torch:[镜像版本号]`

`1.8.1-cuda10.2-dev`, `1.8.1-cuda11.1-dev`

>CUDA HOME `from torch.utils.cpp_extension import CUDA_HOME`, CUDA architectures with `torch.cuda.get_arch_list()`, NVCC gencode flags with `torch.cuda.get_gencode_flags()`.

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
t=test && docker run -d -p 9000:9000 --ipc=host --name ${t} -v "$(pwd)"/${t}:/workspace flystarhe/python:3.8
t=test && docker run --gpus device=0,1 -d -p 9000:9000 --ipc=host --name ${t} -v "$(pwd)"/${t}:/workspace flystarhe/python:3.8
```

* [http://ip:9000/?token=hi](#) for `dev`
* `/usr/sbin/sshd -D -p 9000` for `ssh` mode
* `python /workspace/app_tornado.py 9000 ${@:2}` for `app` mode

## docker hub
```
docker tag local-image:tagname new-repo:tagname
docker push new-repo:tagname
```

## test app
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

## notes
```
# apt-get install -y openssh-server
# RUN mkdir -p /run/sshd && mkdir -p ~/.ssh && echo "# ssh keys" > ~/.ssh/authorized_keys

# sed -i 's/http:\/\/archive.ubuntu.com/https:\/\/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list
# conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main
# rm -rf /etc/apt/sources.list.d/cuda.list /etc/apt/sources.list.d/nvidia-ml.list
# pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
# https://mirrors.tuna.tsinghua.edu.cn/help/anaconda/
```
