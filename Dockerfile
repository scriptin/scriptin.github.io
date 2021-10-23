FROM jekyll/jekyll:4.2.0
MAINTAINER Dmitry Shpika

RUN npm install -g less@^4.1.2 less-plugin-clean-css@1.5.1

VOLUME /src
WORKDIR /src
EXPOSE 4000

ENTRYPOINT jekyll serve --drafts --host 0.0.0.0 --port 4000 --config _config.yml,_config_dev.yml
