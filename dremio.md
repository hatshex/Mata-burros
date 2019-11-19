#### Dremio

##### Getting Started

``` zsh
docker pull dremio/dremio-oss
```
  
```
docker run -p 9047:9047 -p 31010:31010 -p 45678:45678 dremio/dremio-oss
```


http://localhost:9047

Nota:
When running Dremio on a single laptop/machine that may experience network or IP changes, the following line can be added to dremio.conf under /etc/dremio/ to allow Dremio to keep working:

```
registration.publish-host: "localhost"

```

