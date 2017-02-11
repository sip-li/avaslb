# Avas Load Balancer

## Usage

You will only need to install the unit file it will pull everything else it needs automatically and it will automatically pull the latest version of the image every time it restarts.


**NOTE**: This is a private repo so for docker to pull the image correctly you have to be logged into docker.

##### If not logged in you need to:
```
docker login -u callforamerica -p <pass>
```


### Install the avaslb.service systemd unit:
```bash
cp avaslb.service /etc/systemd/system/
```

### Create the environment file:
```
echo "UPSTREAM_AVAS=<ip-address>,<ip-address>,<ip-address>,<ip-address>" >> /etc/default/avaslb.env
```

### Start the avaslb.service:
```bash
systemctl start avaslb
```

### If everything is working set it to auto start:
```bash
systemctl enable avaslb
```

## How to

### Get logs
```bash
# without follow
docker logs avaslb.service

# with follow
docker logs -f avaslb.service

# get logs for the systemd unit supervising the container
journalctl -f -u avaslb
```

### Test
```bash
curl -v localhost:80
```

### Get status
```bash
systemctl status avaslb
```

### Restart container
```bash
systemctl restart avaslb
```

### Stop container
```bash
systemctl stop avaslb
```

### Start container
```bash
systemctl start avaslb
```

### Disable from auto starting
```bash
systemctl disable avaslb
```

### Change the Upstream proxies
The upstream proxies are read from the environment variable `UPSTREAM_AVAS` of which the value is a comma delimited list of ip addresses or hostnames.

* Edit the systemd unit file: `/etc/systemd/system/avaslb.service`.  On line 15 you'll see `UPSTREAM_AVAS=xxx.xxx.xxx.xxx,xxx.xxx.xxx.xxx,etc`.
* Reload the units: `systemctl daemon-reload`.
* Restart the service: `systemctl restart avaslb`.
* Check that the service is running with no errors: `systemctl status avaslb`

### Stats
Goto the following url: [http://localhost/basic_status](http://localhost/basic_status)

```yaml
Credentials:
  user: admin
  pass: <same as docker login>
```

Stats are really basic on open source nginx and nginx plus is ridiculous. If you need more stats you should use another tool that parses the logs like GoAccess [https://goaccess.io/](https://goaccess.io/)
