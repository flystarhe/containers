# PyTorch

## Notes
```sh
git clone https://github.com/flystarhe/containers.git && \
cd containers/torch

t=v2.1.0-cuda11.8 && \
docker build -t flystarhe/torch:${t} -f ${t} .

docker tag build/torch:${t} flystarhe/torch:${t}
docker push flystarhe/torch:${t}

n=hejian-torch
t=flystarhe/torch:v2.1.0-cuda11.8
docker run --restart=always --gpus all -d -p 7000:9000 -p 7001:9001 --ipc=host --name ${n} --hostname ${n} -v "$(pwd)":/workspace ${t} [notebook|ssh|app]
```
