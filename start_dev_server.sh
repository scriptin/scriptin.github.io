#!/bin/bash
lessc -x less/style.less > css/style.min.css
sudo jekyll serve --watch --host 0.0.0.0 --port 80 --config _config_dev.yml
