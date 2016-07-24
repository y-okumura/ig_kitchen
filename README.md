OpenIGのチュートリアルをansibleでやってみる
--------------------------------------

前準備
=====

### 必要なソフトウェア

また、[bundler](http://bundler.io)（及び[Ruby](https://www.ruby-lang.org/ja/downloads/)と[RubyGems](https://rubygems.org/pages/download)）と[vagrant](https://www.vagrantup.com)がインストールされている必要があります。

### 事前にダウンロードしておく必要があるもの

openigをcurlで取って来るのが困難だったため、openigのwarファイルは事前にダウンロードして置くこととしました。
[このリンク](https://backstage.forgerock.com/cp/portal/cloudstorage/AVKC50BRwLBPh3c27BPO?redirect)から事前にダウンロードして、modulesフォルダに入れてください。(要アカウント)

### hosts ファイル

openIGのチュートリアルの結果を確認するために、以下の記述をhostsファイルに記載する必要があります。

```
192.168.33.10 www.example.com
```

### bundle install

必要なものはGemfileにまとめているので、

```
bundle install --path vendor/bundle
```

として必要なライブラリを取得してください。
