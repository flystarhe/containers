# mmdet

## Data
```sh
wget -q https://github.com/flystarhe/containers/releases/download/v0.2.0/coco2017_cat_dog.tar
```

## Notes
```sh
git clone https://github.com/flystarhe/containers.git && \
cd containers/mmdet

t=v3.2.0 && \
docker build -t flystarhe/mmdet:${t} -f ${t} .

docker tag build/mmdet:${t} flystarhe/mmdet:${t}
docker push flystarhe/mmdet:${t}

n=hejian-mmdet
docker run --restart=always --gpus all -d -p 7000:9000 -p 7001:9001 --ipc=host --name ${n} --hostname ${n} -v "$(pwd)":/workspace flystarhe/mmdet:${t} [notebook|ssh|app]

# line 1
# http://hostname:7000/?token=hi
# https://github.com/flystarhe/containers/tree/main/mmdet/get_started.ipynb

# line 2
docker exec -it test bash
docker stop test
docker rm test
```
