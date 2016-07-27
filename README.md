# [OpenIGのgetting started](https://backstage.forgerock.com/#!/docs/openig/4/gateway-guide#chap-quickstart)をansibleでやってみたkitchen

前準備
=====

### 必要なソフトウェア

[bundler](http://bundler.io)（及び[Ruby](https://www.ruby-lang.org/ja/downloads/)と[RubyGems](https://rubygems.org/pages/download)）と[vagrant](https://www.vagrantup.com) (及び[Python](https://www.python.org)) がインストールされている必要があります。

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

実行方法
=======

```
bundle exec kitchen test
```

で環境の立ち上げからテスト、シャットダウンまで自動で行います。  
実際に立ち上げた画面を見るためには、

```
vagrant up
```

して、 http://www.example.com:8080/ にアクセスください。

起きていること
===========

www.example.com(192.168.33.10)には8080ポートにOpenIGの乗ったjettyが、8081ポートにはOpenIGのドキュメントを表示するだけの小さなHTTPサーバーが乗っています。

[openigの設定](roles/openig-config_for_openig-doc/templates/config.json)のテンプレートに[変数定義](roles/openig-config_for_openig-doc/vars/main.yml)が展開され、次のようなhandlerが作成されます。

```json:handler定義
"handler": {
    "type": "Router",
    "audit": "global",
    "baseURI": "http://www.example.com:8081",
    "capture": "all"
},
```
