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

## As background-daemon.

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

## As interactive-shell for scrapy

```bash
$ cat > quotes_spider.py << _EOF_
import scrapy


class QuotesSpider(scrapy.Spider):
    name = "quotes"
    start_urls = [
        'http://quotes.toscrape.com/tag/humor/',
    ]

    def parse(self, response):
        for quote in response.css('div.quote'):
            yield {
                'text': quote.css('span.text::text').extract_first(),
                'author': quote.xpath('span/small/text()').extract_first(),
            }

        next_page = response.css('li.next a::attr("href")').extract_first()
        if next_page is not None:
            yield response.follow(next_page, self.parse)
_EOF_

$ docker-compose run --rm scrapy
>>> scrapy runspider quotes_spider.py -o quotes.json
>>> exit
```



[1]: https://github.com/scrapy/scrapy
[2]: https://github.com/scrapy/scrapyd
[3]: https://github.com/python-pillow/Pillow