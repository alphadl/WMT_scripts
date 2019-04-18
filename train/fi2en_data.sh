#!/bin/bash

EN_NUM=50000
FI_NUM=50000

SRC=en_fi${FI_NUM}/'Total.'${EN_NUM}'.fi.bpe'
TGT=en_fi${FI_NUM}/'Total.'${FI_NUM}'.en.bpe'

SRC_TRAIN='fi'
TGT_TRAIN='en'

NUM=5000

mkdir -p fi2en

python /project/LIAM/work/WMT19/code/OpenNMT-py/preprocess.py \
-train_src ${SRC} -train_tgt ${TGT} \
-valid_src newstest2018-fien-src.true.fi.bpe -valid_tgt newstest2018-fien-ref.true.en.bpe \
-save_data fi2en/fi2en \
-tgt_vocab_size 50000 -src_vocab_size 50000 \
-src_seq_length 80 -tgt_seq_length 80 \

echo "all done"
