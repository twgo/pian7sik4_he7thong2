# pian7sik4_he7thong2
Piān-sik Hē-thóng

## Ka bo phone e su theh-tiau.
```
cat line | grep '[0-9]*' -o | awk '{print $1"d"}' > line_sed
cat lexicon_guan.txt | sed -f line_sed > lexicon.txt
```
