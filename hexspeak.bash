#!/bin/bash

# joseph.tingiris@gmail.com

# use environment word file or default ...
if [ ${#WORDS_FILE} -eq 0 ]; then
    WORDS_FILE=/usr/share/dict/words
fi

if [ ! -r "${WORDS_FILE}" ]; then
    printf "\ncan't find word file '${WORDS_FILE}'\n\n"
    exit 1
fi

# if it's an integer then the first argument matches the length of the resulting hexword
declare -i HEXWORD_LENGTH
if [[ ${1} =~ ^[0-9]+ ]]; then
    # it's an integer, use it
    HEXWORD_LENGTH=${1}
else
    # it's empty or not an integer; all words are processed
    HEXWORD_LENGTH=0
fi

# array of this=that (replacements); order matters
THISISTHATS=()
THISISTHATS+=("ONE=1")
THISISTHATS+=("TWO=2")
THISISTHATS+=("TOO=2")
THISISTHATS+=("^TO=2")
THISISTHATS+=("THREE=3")
THISISTHATS+=("FORE=4")
THISISTHATS+=("FOUR=4")
THISISTHATS+=("FOR=4")
THISISTHATS+=("FIVE=5")
THISISTHATS+=("SIX=6")
THISISTHATS+=("SEVEN=7")
THISISTHATS+=("REAT=R8")
THISISTHATS+=("ATE=8")
THISISTHATS+=("NINE=9")
THISISTHATS+=("A=4")
THISISTHATS+=("E=3")
THISISTHATS+=("I=1")
THISISTHATS+=("G=6")
THISISTHATS+=("L=1")
THISISTHATS+=("O=0")
THISISTHATS+=("S=5")
THISISTHATS+=("T=7")

HEXWORDS=0 # counter
declare -u WORD
for WORD in $(cat "${WORDS_FILE}" | sort -u); do
    IS_HEXWORD=1 # false

    HEXWORD=${WORD}

    # strip these ...
    HEXWORD=${HEXWORD//\'/}
    HEXWORD=${HEXWORD//\"/}
    HEXWORD=${HEXWORD//-/}
    HEXWORD=${HEXWORD//./}

    # test; replace this with that
    for THISISTHAT in ${THISISTHATS[@]}; do
        THIS=${THISISTHAT%%=*}
        if [[ "${HEXWORD}" =~ ${THIS} ]]; then
            IS_HEXWORD=0 # preliminary, true
            THAT=${THISISTHAT##*=}
            # don't put this simple regex match in that string
            THIS=${THIS//^/}
            THIS=${THIS//$/}
            HEXWORD=${HEXWORD//${THIS}/${THAT}}
        fi
    done

    # re-test; some characters may have been replaced while others weren't
    for NOTHEX in {G..Z}; do
        if [[ "${HEXWORD}" == *${NOTHEX}* ]]; then
            IS_HEXWORD=1 # definitive, false
        fi
    done

    if [ ${IS_HEXWORD} -eq 0 ]; then
        if [ ${HEXWORD_LENGTH} -eq 0 ] || [ ${#HEXWORD} -eq ${HEXWORD_LENGTH} ]; then
            # if length is zero or matches
            let HEXWORDS=${HEXWORDS}+1
            printf "[%b] %s = %s\n" ${HEXWORDS} ${HEXWORD} ${WORD}
        fi
    fi

done
