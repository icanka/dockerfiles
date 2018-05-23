# scrapyd
=======

![](http://dockeri.co/image/raflman/scrapyd)

Alpine based scrapyd image.

[Scrapy](https://github.com/scrapy/scrapy.git) is an open source and collaborative framework for extracting the
data you need from websites. In a fast, simple, yet extensible way.

[Scrapyd][2] is a service for running Scrapy spiders.  It allows you to deploy
your Scrapy projects and control their spiders using a HTTP JSON API.

Deploy and Control your spiders from host.Image does not include scrapyd-client nor scrapyd_api.

- `scrapy`: git+https://github.com/scrapy/scrapy.git
- `scrapyd`: git+https://github.com/scrapy/scrapyd.git


## Run it as background-daemon.

```sh
docker run -d --restart always --name my-crawler -p 6800:6800 raflman/scrapyd
```



[1]: https://github.com/scrapy/scrapy
[2]: https://github.com/scrapy/scrapyd