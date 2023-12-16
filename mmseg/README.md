# mmseg

## Notes
```sh
git clone https://github.com/flystarhe/containers.git && \
cd containers/mmseg

t=v1.2.2 && \
docker build -t flystarhe/mmseg:${t} -f ${t} .

docker tag build/mmseg:${t} flystarhe/mmseg:${t}
docker push flystarhe/mmseg:${t}

n=docker-mmseg
docker run --restart=always --gpus all -d -p 7000:9000 -p 7001:9001 --ipc=host --name ${n} --hostname ${n} -v "$(pwd)":/workspace flystarhe/mmseg:${t} [notebook|ssh|app]
```
