### Start up

* boot2docker
```
boot2docker init
boot2docker start
```
* build
```
docker build -t nmochizuki/supervisord .
```
* start
```
docker run -p 80 -p 2222 -d nmochizuki/supervisord
```

If an error occured, try next command.
```
boot2docker delete
```

### Others

* delete docker images
```
for image in $(docker images | awk '{ print $3 }' | grep -v IMAGE); do docker rmi $image; done
```
* delete docker container
```
for i in $(docker ps -a | awk '{ print $1 }' | grep -v CONTAINER); do docker rm ${i}; done
```
* check container ip
```
docker inspect --format="{{ .NetworkSettings.IPAddress }}" XXXX
```

