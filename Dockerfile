FROM ruby:2.1
MAINTAINER Dmitry Shpika <***REMOVED***>

RUN apt-get update \
  && apt-get install -y \
     python-pygments \
     ca-certificates \
     curl \
  && apt-get clean

RUN gpg --keyserver pgp.mit.edu --recv-keys 7937DFD2AB06298B2293C3187D33FF9D0246406D

ENV NODE_VERSION 0.10.33
ENV NPM_VERSION 2.1.10

RUN curl -SLO "http://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
	&& curl -SLO "http://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
	&& gpg --verify SHASUMS256.txt.asc \
	&& grep " node-v$NODE_VERSION-linux-x64.tar.gz\$" SHASUMS256.txt.asc | sha256sum -c - \
	&& tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
	&& rm "node-v$NODE_VERSION-linux-x64.tar.gz" SHASUMS256.txt.asc \
	&& npm install -g npm@"$NPM_VERSION" \
	&& npm cache clear

RUN gem install jekyll kramdown
RUN npm install -g less@1.7.3

VOLUME /src
WORKDIR /src
EXPOSE 4000

ENTRYPOINT ["jekyll", "serve", "--drafts", "--watch", "--host", "0.0.0.0", "--port", "4000", "--config", "_config.yml,_config_dev.yml"]
