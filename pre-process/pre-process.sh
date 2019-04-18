#!/bin/sh

mosesdecoder=/project/LIAM/work/WMT19/code/mosesdecoder
bpe=/project/LIAM/work/WMT19/code/subword-nmt

lng=en

${mosesdecoder}/scripts/tokenizer/normalize-punctuation.perl -l ${lng} | \
${mosesdecoder}/scripts/tokenizer/tokenizer.perl -a -l ${lng} | \
${mosesdecoder}/scripts/recaser/truecase.perl -model truecase-model.en | \
${bpe}/subword_nmt/apply_bpe.py -c processed/en_fi50000/en.50000.codes 
