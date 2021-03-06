#!/bin/bash

set -e

rm -r Gen/ || true
hprotoc --prefix Gen caffe.proto
(
    cd Gen
    for f in $(find . -iname "*.hs"); do 
        echo $f
        ../add_lenses.py $f || true
    done
)

protoc caffe.proto --python_out=Gen/
touch Gen/__init__.py
