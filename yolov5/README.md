# YOLOv5

## Notes
```sh
git clone https://github.com/flystarhe/containers.git && \
cd containers/yolov5

t=v7.0-torch2.1.0-cuda11.8 && \
docker build -t build/yolov5:${t} -f ${t} .

docker tag build/yolov5:${t} flystarhe/yolov5:${t}
docker push flystarhe/yolov5:${t}

docker run --restart=always --gpus all -d -p 7000:9000 -p 7001:9001 --ipc=host --name ${n} --hostname ${n} -v "$(pwd)":/workspace flystarhe/yolov5:${t} [notebook|ssh|app]
```
