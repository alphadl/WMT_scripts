#!/bin/bash

NMT_DIR=/project/LIAM/work/WMT19/code/OpenNMT-py/
MOSES_DIR=/project/LIAM/work/WMT19/code/mosesdecoder/scripts
MODEL=fi2en/fi2en/models

python ${NMT_DIR}/translate.py -src newstest2018-fien-src.true.fi.bpe -tgt newstest2018-fien-ref.true.en.bpe \
-model ${MODEL}/ensemble_big_before20w_added.pt \
-output pred.newstest2018-fien-ref.bpe.ensemble_big_before20w_added \
-report_time \
-gpu 0 \
-batch_size 256 \
-beam_size 5 \
-max_length 80 

sed -r 's/(@@ )|(@@ ?$)//g' < newstest2018-fien-ref.true.en.bpe > newstest2018-fien-ref.true.en.bpe.norm
sed -r 's/(@@ )|(@@ ?$)//g' < pred.newstest2018-fien-ref.bpe.ensemble_big_before20w_added > pred.newstest2018-fien-ref.bpe.ensemble_big_before20w_added.norm

#de- truecase & de- tokenize
perl ${MOSES_DIR}/recaser/detruecase.perl < newstest2018-fien-ref.true.en.bpe.norm > newstest2018-fien-ref.true.en.bpe.norm2
perl ${MOSES_DIR}/tokenizer/detokenizer.perl -l en < newstest2018-fien-ref.true.en.bpe.norm2 > newstest2018-fien-ref.true.en.bpe.norm3

perl ${MOSES_DIR}/recaser/detruecase.perl < pred.newstest2018-fien-ref.bpe.ensemble_big_before20w_added.norm > pred.newstest2018-fien-ref.bpe.ensemble_big_before20w_added.norm2
perl ${MOSES_DIR}/tokenizer/detokenizer.perl -l en < pred.newstest2018-fien-ref.bpe.ensemble_big_before20w_added.norm2 > pred.newstest2018-fien-ref.bpe.ensemble_big_before20w_added.norm3

# BLEU
perl ${NMT_DIR}tools/multi-bleu.perl  newstest2018-fien-ref.true.en.bpe.norm2 < pred.newstest2018-fien-ref.bpe.ensemble_big_before20w_added.norm2 > pred.newstest2018-fien-ref.bpe.ensemble_big_before20w_added.norm2.BLEU

perl ${NMT_DIR}tools/multi-bleu.perl  newstest2018-fien-ref.true.en.bpe.norm3 < pred.newstest2018-fien-ref.bpe.ensemble_big_before20w_added.norm3 > pred.newstest2018-fien-ref.bpe.ensemble_big_before20w_added.norm3.BLEU

perl ${NMT_DIR}tools/multi-bleu.perl  newstest2018-fien-ref.true.en.bpe < pred.newstest2018-fien-ref.bpe.ensemble_big_before20w_added > pred.newstest2018-fien-ref.bpe.ensemble_big_before20w_added.BLEU

echo "translate fi2en done"
