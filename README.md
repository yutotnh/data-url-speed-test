# data-url-speed-test

Data URL scheme を使った場合と使わなかった場合とでHTMLの表示速度がどの程度変わるのかを確かめるためのデータ置き場

## ディレクトリ構成

- images
  - ファイル名と同じ容量のファイルが格納されている
  - 1kB.svgの場合、1000Bになる (1024Bではない)
- html
  - HTML ファイルが生成される
  - standard ディレクトリ ... 相対パスで images ディレクトリにある画像を表示するHTMLがある
  - dataurl ディレクトリ ... Data URL scheme を利用して画像を表示するHTMLがある

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
