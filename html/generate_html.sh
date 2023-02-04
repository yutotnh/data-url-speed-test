#!/bin/bash

set -eu

function generate_standard() {
    local BODY=""
    for ((i = 1; i <= ${2}; i++)); do
        BODY+="<img src='../../../images/${1}/${1}_${i}.svg' />"
    done
    cp base.html standard/${BASENAME}/${BASENAME}_${2}.html
    sed -i -e "s|__title__|Data URL scheme を使わないHTML ${1} ${2}枚|g" standard/${BASENAME}/${BASENAME}_${2}.html
    sed -i -e "s|__body__|${BODY}|" standard/${BASENAME}/${BASENAME}_${2}.html
}

function generate_dataurl() {
    cp base.html dataurl/${BASENAME}/${BASENAME}_${2}.html
    sed -i -e "s|__title__|Data URL scheme を使ったHTML ${1} ${2}枚|g" dataurl/${BASENAME}/${BASENAME}_${2}.html

    IMG_TEMPFILE=$(mktemp)
    TEMPFILE=$(mktemp)
    atexit() {
        [[ -n ${IMG_TEMPFILE-} ]] && rm -f "$IMG_TEMPFILE"
        [[ -n ${TEMPFILE-} ]] && rm -f "$TEMPFILE"
    }

    echo "<img src='data:image/svg+xml;base64,$(base64 -w 0 ../images/${1}.svg)' />" >>${IMG_TEMPFILE}

    ditits=${#2}
    for ((i = 0; i <= ${2}; i++)); do
        if [[ $i -ne 0 ]]; then
            cat "${IMG_TEMPFILE}" >>"${TEMPFILE}"
        fi
        printf "\r\t[%${ditits}d/%d] Generating HTML with ${2} ${BASENAME} images." $i $2
    done

    sed -i "/__body__/ r ${TEMPFILE}" dataurl/${BASENAME}/${BASENAME}_${2}.html
    sed -i -e "s|__body__||g" dataurl/${BASENAME}/${BASENAME}_${2}.html
    echo ""
}

for file in ../images/*.svg; do
    BASENAME=$(basename "${file%.*}")

    echo "------ ${BASENAME} ------"

    # Data URL scheme を使わない場合
    echo "Generate standard HTML"
    mkdir -p standard/${BASENAME}
    echo '*' >standard/.gitignore
    generate_standard ${BASENAME} 0
    generate_standard ${BASENAME} 1
    generate_standard ${BASENAME} 10
    generate_standard ${BASENAME} 100

    # Data URL scheme を使う場合
    echo "Generate Data URL scheme HTML"
    mkdir -p dataurl/${BASENAME}
    echo '*' >dataurl/.gitignore
    generate_dataurl ${BASENAME} 0
    generate_dataurl ${BASENAME} 1
    generate_dataurl ${BASENAME} 10
    generate_dataurl ${BASENAME} 100

    echo ""
done
