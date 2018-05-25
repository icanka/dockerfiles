# scrapyd
=======

Alpine based scrapyd image.

[Scrapy][1] is an open source and collaborative framework for extracting the
data you need from websites. In a fast, simple, yet extensible way.

[Scrapyd][2] is a service for running Scrapy spiders.  It allows you to deploy
your Scrapy projects and control their spiders using a HTTP JSON API.

[pillow][3] is the Python Imaging Library to support the ImagesPipeline.


Deploy and Control your spiders from host.Image does not include scrapyd-client nor scrapyd_api.

## docker-compose.yml

```yaml
scrapyd:
  image: raflman/scrapyd
  ports:
    - "6800:6800"
  volumes:
    - ./data:/scrapyd
    - scrapy-packages-vol:/usr/lib/python3.6/site-packages
  restart: always

scrapy:
  image: raflman/scrapyd
  command: sh
  volumes:
    - .:/code
    - scrapy-packages-vol:/usr/lib/python3.6/site-packages
  working_dir: /code
  restart: always
```

## Run it as background-daemon.

```bash
$ docker-compose up -d scrapyd
$ pip install scrapyd-client

$ scrapy startproject myproject
$ cd myproject
$ scrapyd-deploy
```


File: scrapy.cfg

```ini
[settings]
default = myproject.settings

[deploy]
url = http://localhost:6800/
project = myproject
```



[1]: https://github.com/scrapy/scrapy
[2]: https://github.com/scrapy/scrapyd
[3]: https://github.com/python-pillow/Pillow