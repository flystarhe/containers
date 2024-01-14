# fiftyone

## Notes
```sh
git clone https://github.com/flystarhe/containers.git && \
cd containers/fiftyone

t=v0.23.1 && \
docker build -t flystarhe/fiftyone:${t} -f ${t} .

docker tag build/fiftyone:${t} flystarhe/fiftyone:${t}
docker push flystarhe/fiftyone:${t}

n=hejian-fiftyone
t=flystarhe/fiftyone:v0.23.1
docker run --restart=always --gpus all -d -p 7000:9000 -p 7001:9001 --ipc=host --name ${n} --hostname ${n} -v "$(pwd)":/workspace ${t} [notebook|ssh|app]
```
