#!/bin/bash

set -eu

function generate_normal() {
    local BODY=""
    for ((i = 1; i <= ${2}; i++)); do
        BODY+="<img src='../../../images/${1}/${1}_${i}.svg' />"
    done
    cp base.html normal/${BASENAME}/${BASENAME}_${2}.html
    sed -i -e "s|__title__|Data URL scheme を使わないHTML ${1} ${2}枚|g" normal/${BASENAME}/${BASENAME}_${2}.html
    sed -i -e "s|__body__|${BODY}|" normal/${BASENAME}/${BASENAME}_${2}.html
}

function generate_dataurl() {
    cp base.html dataurl/${BASENAME}/${BASENAME}_${2}.html
    sed -i -e "s|__title__|Data URL scheme を使ったHTML ${1} ${2}枚|g" dataurl/${BASENAME}/${BASENAME}_${2}.html
    local IMG_TAG
    IMG_TAG="<img src='data:image/svg+xml;base64,$(base64 -w 0 ../images/${1}.svg)' />"
    TEMPFILE=$(mktemp)
    echo $IMG_TAG >$TEMPFILE
    for ((i = 1; i <= ${2}; i++)); do
        sed -i "/__body__/ r $TEMPFILE" dataurl/${BASENAME}/${BASENAME}_${2}.html
    done
    sed -i -e "s|__body__||g" dataurl/${BASENAME}/${BASENAME}_${2}.html
}

for file in ../images/*.svg; do
    BASENAME=$(basename "${file%.*}")

    # Data URL scheme を使わない場合
    mkdir -p normal/${BASENAME}
    echo '*' >normal/.gitignore
    generate_normal ${BASENAME} 0
    generate_normal ${BASENAME} 1
    generate_normal ${BASENAME} 10
    generate_normal ${BASENAME} 100

    # Data URL scheme を使う場合
    mkdir -p dataurl/${BASENAME}
    echo '*' >dataurl/.gitignore
    generate_dataurl ${BASENAME} 0
    generate_dataurl ${BASENAME} 1
    generate_dataurl ${BASENAME} 10
    generate_dataurl ${BASENAME} 100
done
