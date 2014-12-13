#!/bin/bash

pygmentize -S default -f html > /src/css/syntax.css
lessc -x less/style.less > /src/css/style.min.css

