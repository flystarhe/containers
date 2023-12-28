# Transformers
- https://huggingface.co/docs/transformers/main/zh/index

## Notes
```sh
git clone https://github.com/flystarhe/containers.git && \
cd containers/transformers

t=lang-torch2.1.0-cuda11.8 && \
docker build -t flystarhe/transformers:${t} -f ${t} .

docker tag build/transformers:${t} flystarhe/transformers:${t}
docker push flystarhe/transformers:${t}

n=docker-transformers
docker run --restart=always --gpus all -d -p 7000:9000 -p 7001:9001 --ipc=host --name ${n} --hostname ${n} -v "$(pwd)":/workspace flystarhe/transformers:${t} [notebook|ssh|app]
```
