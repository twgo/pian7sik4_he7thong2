# pian7sik4_he7thong2
Piān-sik Hē-thóng

## Tshi
```
mkdir tshi3
cp data/train_free/ tshi3/ -r
mv tshi3/train_free/utt2spk tshi3/train_free/utt2spk.old
head tshi3/train_free/utt2spk.old -n 1 > tshi3/train_free/utt2spk 

time bash -x decode_nnet3.sh exp/chain/tdnn_1a_sp/graph_test/ hethong/lang-3grams/ tshi3/train_free exp/chain/tdnn_1a_sp/decode_tshi
```

## Ka bo phone e su theh-tiau.
```
cat line | grep '[0-9]*' -o | awk '{print $1"d"}' > line_sed
cat lexicon_guan.txt | sed -f line_sed > lexicon.txt
```
