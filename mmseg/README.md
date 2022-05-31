# MMSegmentation

## Notes
```sh
git clone https://github.com/flystarhe/containers.git && \
cd containers/mmseg

t=v0.24.1 && \
docker build -t build/mmseg:${t} -f ${t} .

docker tag build/mmseg:${t} flystarhe/mmseg:${t}
docker push flystarhe/mmseg:${t}
```

simple case
```sh
t=flystarhe/mmseg:v0.24.1 && \
docker run --gpus all -d -p 7000:9000 --ipc=host --name test -v "$(pwd)":/workspace ${t} notebook

docker exec -it test bash
docker stop test
docker rm test
```
