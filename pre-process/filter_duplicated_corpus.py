# -*-coding:utf-8-*-
# Author: alphadl
# Email: liangding.liam@gmail.com
# filter_corpus_from_dev.py 21/3/19 22:37

import sys
import codecs

r1 = codecs.open(sys.argv[1], 'r', encoding='utf-8')
r2 = codecs.open(sys.argv[2], 'r', encoding='utf-8')

# f4 = open(sys.argv[4], 'r', encoding='utf-8')
w1 = codecs.open(sys.argv[1] + '.new', 'w', encoding='utf-8')
w2 = codecs.open(sys.argv[2] + '.new', 'w', encoding='utf-8')

src = r1.readlines()
tgt = r2.readlines()

src_strip = [line.strip() for line in src]
tgt_strip = [line.strip() for line in tgt]

clean_src, clean_tgt = [], []

total_count = 0
clean_count = 0

for s, t in zip(src_strip, tgt_strip):


    if lines2strip[i] not in lines1strip:
        # l.append(lines2strip[i])
        f4.write(lines2[i])
        f5.write(lines3[i])
    else:
        l.append(lines2strip[i])
for i in lines1strip:
    if i not in l:
        print(i)
print('---------')
# for i in l:
#    if l.count(i) >1:
#       print(i)
