# .gitlab-ci/scripts/build/nodejs/73_lang_nodejs_build.sh # Node.js Build
#!/bin/bash

set -eu

echo "===================================="
echo "Node.js Build Started"
echo "===================================="

mkdir -p build-output

npm ci
npm run build

if [ ! -d dist ]; then
    echo "dist directory not found"
    exit 1
fi

cp -r dist build-output/

echo "Artifact:"
ls -l build-output

echo "Node.js Build Finished"
