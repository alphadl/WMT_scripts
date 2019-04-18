#!/bin/bash

EN_NUM=50000
FI_NUM=50000

DIR=fi2en/fi2en

NMT_DIR=path_to_NMT

tensorboard_dir=fi2en/runs
SAVE=fi2en/fi2en/models/transformer_checkpoints

mkdir -p ${SAVE}
mkdir -p ${tensorboard_dir}

python ${NMT_DIR}/train.py -data ${DIR} -save_model ${SAVE} \
-layers 6 -rnn_size 512 -word_vec_size 512 -transformer_ff 2048 -heads 8  \
-encoder_type transformer -decoder_type transformer -position_encoding \
-train_steps 300000  -max_generator_batches 2 -dropout 0.1 \
-batch_size 4096 -batch_type tokens -normalization tokens  -accum_count 2 \
-optim adam -adam_beta2 0.998 -decay_method noam -warmup_steps 8000 -learning_rate 2 \
-max_grad_norm 0 -param_init 0  -param_init_glorot \
-label_smoothing 0.1 -valid_steps 2000 -save_checkpoint_steps 2000 \
-world_size 2 -gpu_ranks 0 1  -tensorboard -tensorboard_log_dir ${tensorboard_dir} \
-train_from ${SAVE}_step_200000.pt

echo "train fi2en done"
