#!/bin/bash

EN='/project/LIAM/work/WMT19/data_fi/fi2en_combine2/syn_8277w.fi'

TOOLS='/project/LIAM/work/WMT19/code/subword-nmt'

EN_NUM=50000
#EN_NUM=20000

FI_NUM=50000


DIR=en_fi${EN_NUM}
mkdir -p $DIR

#python ${TOOLS}/subword_nmt/learn_bpe.py -s ${EN_NUM} < ${EN} > ${DIR}/fi.${EN_NUM}.codes
#python ${TOOLS}/subword_nmt/apply_bpe.py -c ${DIR}/fi.${EN_NUM}.codes < ${EN} > ${DIR}/Total.${EN_NUM}.bpe
python ${TOOLS}/subword_nmt/apply_bpe.py -c ${DIR}/fi.${EN_NUM}.codes < ${EN} > ${EN}.bpe

echo "FI done"
