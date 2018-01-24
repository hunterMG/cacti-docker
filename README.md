## cacti-docker

Get Cacti runnning with Docker.

### How to use ?
#### 1st time :
```bash
mkdir net-monitor
cd net-monitor
git clone https://github.com/hunterMG/cacti-docker.git
git clone https://github.com/hunterMG/cacti.git
cd cacti-docker
docker-compose up
```
Then open http://localhost in web browser.  
"Ctrl + C" to stop it.
#### next time
```bash
cd net-monitor/cacti-docker
docker-compose up
```

### Reset
If you deleted the container, the file `cacti/install.lock` needs to be deleted before your next "docker-compose up".