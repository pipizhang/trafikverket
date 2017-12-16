# trafikverket
Monitor available Swedish driving test and get notified when there are new recent test come up

![screenshot](https://github.com/pipizhang/trafikverket/blob/master/screenshots/01.png)

## Getting started
Start docker container
```bash
$ make docker
```

Install Gem dependencies
```bash
$ make install
```

Update settings
```bash
cp config/env.example config/.env
# then puts account settings to config/.env
cp config/curl.example config/curl
# then puts value of 'Copy as cURL' from Chrome browser to config/curl
```
> Prerequisites: trafikverket.se account and Slack token

Show only displays the earlest of available driving tests
```bash
$ make show
```

Start monitor
```bash
$ make run
```
