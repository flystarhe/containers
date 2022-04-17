# GCC

- [Official Images/gcc](https://hub.docker.com/_/gcc)

## Start a GCC instance running your app
使用此映像的最直接方法是使用gcc容器作为构建和运行时环境。按照以下内容编写`Dockerfile`：
```docker
FROM gcc:4.9
COPY . /usr/src/myapp
WORKDIR /usr/src/myapp
RUN gcc -o myapp main.c
CMD ["./myapp"]
```

然后，构建并运行Docker映像：
```shell
docker build -t my-gcc-app .
docker run -it --rm --name my-running-app my-gcc-app
```

## Compile your app inside the Docker container
在某些情况下，可能不适合在容器内运行应用。若要编译但不在Docker实例中运行应用，可以编写如下内容：
```shell
docker run --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp gcc:4.9 gcc -o myapp myapp.c
```

如果你有`Makefile`，你可以改为在你的容器内运行`make`命令：
```shell
docker run --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp gcc:4.9 make
```
