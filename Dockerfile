FROM nnet3-hunlianliau
MAINTAINER sih4sing5hong5


COPY --from=twgo/gi2gian5-boo5hing-hun3lian7 /opt/bun1.arpa .
COPY --from=twgo/gi2gian5-boo5hing-hun3lian7 /opt/bun3.arpa .
RUN gzip bun1.arpa && gzip bun3.arpa
RUN mkdir -p hethong/dict
RUN cp -r data/local/dict/[^l]* hethong/dict
COPY lexicon.txt hethong/dict/lexicon.txt
RUN utils/prepare_lang.sh hethong/dict "<UNK>" hethong/local/lang_log hethong/lang_dict
RUN utils/format_lm.sh hethong/lang_dict bun1.arpa.gz hethong/dict/lexicon.txt hethong/lang
RUN utils/build_const_arpa_lm.sh bun3.arpa.gz hethong/lang hethong/lang-3grams

RUN utils/mkgraph.sh --self-loop-scale 1.0 hethong/lang exp/chain/tdnn_1a_sp/ exp/chain/tdnn_1a_sp/graph_test
RUN wget https://github.com/sih4sing5hong5/kaldi/raw/taiwanese/egs/taiwanese/s5c/%E6%9C%8D%E5%8B%99%E4%BE%86%E8%A9%A6nnet3.sh -O decode_nnet3.sh

CMD bash -x decode_nnet3.sh exp/chain/tdnn_1a_sp/graph_test/ hethong/lang-3grams/ tshi3/train_free exp/chain/tdnn_1a_sp/decode_tshi

