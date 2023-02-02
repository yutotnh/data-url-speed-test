#!/bin/bash

set -eu

function generate() {
    local BODY=""
    for ((i = 1; i <= ${2}; i++)); do
        BODY+="<img src=\"../../images/${1}/${1}_${i}.svg\" />"
    done
    cp base.html ${BASENAME}/${BASENAME}_${2}.html
    sed -i -e "s|__title__|${1}_${2}|" ${BASENAME}/${BASENAME}_${2}.html
    sed -i -e "s|__body__|${BODY}|" ${BASENAME}/${BASENAME}_${2}.html
}

for file in ../images/*.svg; do
    BASENAME=$(basename "${file%.*}")
    mkdir -p ${BASENAME}
    echo '*' >${BASENAME}/.gitignore
    generate ${BASENAME} 0
    generate ${BASENAME} 1
    generate ${BASENAME} 10
    generate ${BASENAME} 100
done
