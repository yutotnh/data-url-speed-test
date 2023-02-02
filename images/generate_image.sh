#!/bin/bash

set -eu

# 実行したカレントディレクトリ中のsvgファイルを複製する
for file in *.svg; do
    BASENAME="${file%.*}"
    mkdir -p ${BASENAME}
    echo '*' >${BASENAME}/.gitignore
    for i in {1..100}; do ln -sf ${PWD}/${file} ${BASENAME}/${BASENAME}_${i}.svg; done
done
