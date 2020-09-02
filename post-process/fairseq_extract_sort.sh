fairseq_generated=$1

grep ^H ${fairseq_generated} | sed 's/^H\-//' | sort -n -k 1 | awk -F '\t' '{print $NF}' |  sacremoses detokenize > ${fairseq_generated}.sorted.detok
