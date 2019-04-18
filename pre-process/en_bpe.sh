#!/bin/bash

EN='/project/LIAM/work/WMT19/data_fi/fi2en_combine2/syn_8277w.en'

TOOLS='/project/LIAM/work/WMT19/code/subword-nmt'

EN_NUM=50000
#EN_NUM=20000

FI_NUM=50000


DIR=en_fi${EN_NUM}

python ${TOOLS}/subword_nmt/apply_bpe.py -c ${DIR}/en.${EN_NUM}.codes < ${EN} > ${EN}.bpe

echo "EN done"
