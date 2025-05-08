# PyTorch

## Notes
```sh
git clone https://github.com/flystarhe/containers.git && \
cd containers/torch

t=v2.1.0-cuda11.8 && \
docker build -t flystarhe/torch:${t} -f ${t} .

docker tag build/torch:${t} flystarhe/torch:${t}
docker push flystarhe/torch:${t}

n="xxx"
t="yyy"
docker run -d --name ${n} --hostname ${n} \
--restart=always --gpus all --network host --ipc=host \
-v "$(pwd)":/workspace ${t} [notebook|ssh|app]
```

## Aliyun
```bash
docker pull registry.cn-hangzhou.aliyuncs.com/flystarhe/torch:[镜像版本号]
docker pull registry.cn-hangzhou.aliyuncs.com/flystarhe/torch:v2.5.1-cuda12.1
```
