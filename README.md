# data-url-speed-test

Data URLを使った場合と使わなかった場合とでHTMLの表示速度がどの程度変わるのかを確かめるためのデータ置き場

## ディレクトリ構成

- images
  - ファイル名と同じ容量のファイルが格納されている
  - 1kB.svgの場合、1000Bになる (1024Bではない)

## 使い方

### データの生成

```bash
git clone https://github.com/yutotnh/data-url-speed-test.git
cd data-url-speed-test
cd images
bash generate_image.sh
cd ../html
bash generate_html.sh
```
