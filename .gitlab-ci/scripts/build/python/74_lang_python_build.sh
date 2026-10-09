# .gitlab-ci/scripts/build/python/74_lang_python_build.sh # Python Build
#!/bin/bash

set -eu

echo "===================================="
echo "Python Build Started"
echo "===================================="

mkdir -p build-output

python -m pip install --upgrade pip
python -m pip install build

python -m build

if [ ! -d dist ]; then
    echo "dist directory not found"
    exit 1
fi

cp -r dist build-output/

echo "Artifact:"
ls -l build-output

echo "Python Build Finished"

