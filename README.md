## Install workstatus.io on Linux
this repo contains bash script to install workstatus on linux


### Install wid single command
switch to root user: `sudo su` & run below command:
```
(apt-get update -qq && apt-get install -y wget >/dev/null 2>&1 || yum install -y wget >/dev/null 2>&1) && bash <(wget -qO- https://raw.githubusercontent.com/aslas-enterprise/workstatus.io/master/workstatus-install.sh)
```