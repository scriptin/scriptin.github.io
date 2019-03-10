FROM jekyll/jekyll:3.8
MAINTAINER Dmitry Shpika

RUN npm install -g less@^3.9.0

VOLUME /src
WORKDIR /src
EXPOSE 4000

ENTRYPOINT ["jekyll", "serve", "--drafts", "--host", "0.0.0.0", "--port", "4000", "--config", "_config.yml,_config_dev.yml"]
