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

## Testing
```
wget https://raw.githubusercontent.com/sih4sing5hong5/kaldi/taiwanese/egs/taiwanese/s5c/%E8%B5%B0%E8%A9%95%E4%BC%B0nnet3.sh -O phingkoo_nnet3.sh
time bash -x phingkoo_nnet3.sh data/lang_free/ tshi3/train_free

```


## Ka bo phone e su theh-tiau.
```
cat line | grep '[0-9]*' -o | awk '{print $1"d"}' > line_sed
cat lexicon_guan.txt | sed -f line_sed > lexicon.txt
```
