#!/bin/bash

# Copyright Istio Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -ex

mkdir -p generated/js generated/img tmp/js


tsc

#Entrypoint for esbuild to bundle and minify through an entrypoint.js file
cat <<EOF > tmp/js/entrypoint.js
import "./constants.js";
import "./utils.js";
import "./feedback.js";
import "./kbdnav.js";
import "./themes.js";
import "./menu.js";
import "./header.js";
import "./sidebar.js";
import "./tabset.js";
import "./prism.js";
import "./codeBlocks.js";
import "./links.js";
import "./resizeObserver.js";
import "./scroll.js";
import "./overlays.js";
import "./lang.js";
import "./callToAction.js";
import "./events.js";
import "./faq.js";
EOF

# Bundle + minify with sourcemap
esbuild tmp/js/entrypoint.js \
  --bundle \
  --minify \
  --sourcemap \
  --target=es6 \
  --outfile=generated/js/all.min.js

esbuild tmp/js/headerAnimation.js \
  --minify \
  --sourcemap \
  --target=es6 \
  --outfile=generated/js/headerAnimation.min.js

esbuild tmp/js/themes_init.js \
  --minify \
  --sourcemap \
  --target=es6 \
  --outfile=generated/js/themes_init.min.js

svgstore -o generated/img/icons.svg src/icons/**/*.svg
