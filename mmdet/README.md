# MMDetection

```sh
wget https://github.com/flystarhe/containers/releases/download/v0.2.0/coco2017_cat_dog.tar
```

## Notes
```sh
git clone https://github.com/flystarhe/containers.git && \
cd containers/mmdet

t=v2.24.1 && \
docker build -t build/mmdet:${t} -f ${t} .

docker tag build/mmdet:${t} flystarhe/mmdet:${t}
docker push flystarhe/mmdet:${t}
```

simple case
```sh
t=flystarhe/mmdet:v2.24.1 && \
docker run --gpus all -d -p 7000:9000 --ipc=host --name test -v "$(pwd)":/workspace ${t} notebook

docker exec -it test bash
docker stop test
docker rm test
```
