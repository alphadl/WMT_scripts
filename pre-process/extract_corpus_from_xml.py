# -*-coding:utf-8-*-
# Author: alphadl
# Email: liangding.liam@gmail.com
# extract_coorpus.py.py 19/3/19 23:18
import xml.dom.minidom
import codecs
import sys

# dom = xml.dom.minidom.parse('newstest2019-enfi-src-ts.en.sgm')
dom = xml.dom.minidom.parse(sys.argv[1])
root = dom.documentElement
print("~" * 10)
corpus = root.getElementsByTagName('seg')
# en, fi = [], []
fi = []

# print("There are", len(corpus) // 2, "sentences.")
print("There are", len(corpus), "sentences.")

# for i in range(len(corpus)):
#     if i%2==0:
#         en.append(corpus[i].firstChild.data.strip()+"\n")
#     else:
#         fi.append(corpus[i].firstChild.data.strip()+"\n")
for i in range(len(corpus)):
    fi.append(corpus[i].firstChild.data.strip()+"\n")

print("Start writing~")

# with codecs.open("newstest2019-enfi-src-ts.en", 'w+',encoding='utf8') as fi_w:
with codecs.open(sys.argv[1]+".extract", 'w+',encoding='utf8') as fi_w:
    print("read en successfully, processing...")
    for fi_index in range(len(fi)):
        if fi_index%10000==0:
            print("FI> processing the",fi_index)
        fi_w.write(fi[fi_index])

# with codecs.open("processed/en-fi.bicleaner07.en", 'w+', encoding='utf8') as en_w:
#     print("read en successfully, processing...")
#     for en_index in range(len(en)):
#         if en_index%10000==0:
#             print("EN> processing the",en_index)
#         en_w.write(en[en_index])

print("Write finished~")
