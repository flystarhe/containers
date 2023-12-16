# YOLOv8

## Notes
```sh
git clone https://github.com/flystarhe/containers.git && \
cd containers/yolov8

t=torch2.1.0-cuda11.8 && \
docker build -t flystarhe/yolov8:${t} -f ${t} .

docker tag build/yolov8:${t} flystarhe/yolov8:${t}
docker push flystarhe/yolov8:${t}

n=docker-yolov8
docker run --restart=always --gpus all -d -p 7000:9000 -p 7001:9001 --ipc=host --name ${n} --hostname ${n} -v "$(pwd)":/workspace flystarhe/yolov8:${t} [notebook|ssh|app]
```
