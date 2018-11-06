ARG KUI=11
FROM dockerhub.iis.sinica.edu.tw/dnn-train:${KUI}
MAINTAINER sih4sing5hong5


COPY --from=twgo/gi2gian5-boo5hing-hun3lian7:tsuanpoosu_ka_su /opt/bun1.arpa .
COPY --from=twgo/gi2gian5-boo5hing-hun3lian7:tsuanpoosu_ka_su /opt/bun3.arpa .
COPY --from=twgo/gi2gian5-boo5hing-hun3lian7:tsuanpoosu_ka_su /opt/pio2.txt .
COPY --from=twgo/gi2gian5-boo5hing-hun3lian7:tsuanpoosu_ka_su /opt/ka.txt .
RUN gzip bun1.arpa && gzip bun3.arpa
RUN mkdir -p hethong/dict
RUN cp -r data/local/dict/[^l]* hethong/dict
COPY lexicon.txt lexicon.txt
COPY 7-11.txt 7-11.txt
RUN cat lexicon.txt ka.txt 7-11.txt | sort -u | sed '/^\s*$/d' > hethong/dict/lexicon.txt
RUN utils/prepare_lang.sh hethong/dict "<UNK>" hethong/local/lang_log hethong/lang_dict
RUN utils/format_lm.sh hethong/lang_dict bun1.arpa.gz hethong/dict/lexicon.txt hethong/lang
RUN utils/build_const_arpa_lm.sh bun3.arpa.gz hethong/lang exp/chain/tdnn_1a_sp/lang-3grams

RUN utils/mkgraph.sh --self-loop-scale 1.0 hethong/lang exp/chain/tdnn_1a_sp/ exp/chain/tdnn_1a_sp/graph_test
RUN wget https://github.com/sih4sing5hong5/kaldi/raw/taiwanese/egs/taiwanese/s5c/%E6%9C%8D%E5%8B%99%E4%BE%86%E8%A9%A6nnet3.sh -O decode_nnet3.sh


CMD bash -x decode_nnet3.sh exp/chain/tdnn_1a_sp/graph_test/ exp/chain/tdnn_1a_sp/lang-3grams/ tshi3/train_free exp/chain/tdnn_1a_sp/decode_tshi

