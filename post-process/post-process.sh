#/bin/sh

mosesdecoder=/project/LIAM/work/WMT19/code/mosesdecoder

lng=fi
sed 's/\@\@ //g' | \
${mosesdecoder}/scripts/recaser/detruecase.perl | \
${mosesdecoder}/scripts/tokenizer/detokenizer.perl -l ${lng}
