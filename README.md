# [OpenIGのgetting started](https://backstage.forgerock.com/#!/docs/openig/4/gateway-guide#chap-quickstart)をansibleでやってみたkitchen

前準備
=====

### 必要なソフトウェア

[bundler](http://bundler.io)（及び[Ruby](https://www.ruby-lang.org/ja/downloads/)と[RubyGems](https://rubygems.org/pages/download)）と,[Ansible](http://www.ansible.com)と[vagrant](https://www.vagrantup.com) (及び[Python](https://www.python.org)) がインストールされている必要があります。

windows上でAnsibleを動かすのは困難なので、Vagrantファイルの末尾、
```ruby:Vagrantfile
  config.vm.provision "ansible" do |ansible|
```
の行を
```ruby:vagrantfile
  config.vm.provision "ansible_local" do |ansible|
```
と書き換えて、仮想マシン上でansibleを動かせるようにすればansibleのインストールは不要となります。

### 事前にダウンロードしておく必要があるもの

openigをcurlで取って来るのが困難だったため、openigのwarファイルは事前にダウンロードして置くこととしました。
[このリンク](https://backstage.forgerock.com/cp/portal/cloudstorage/AVKC50BRwLBPh3c27BPO?redirect)から事前にダウンロードして、modulesフォルダに入れてください。(要アカウント)

### bundle install

必要なものはGemfileにまとめているので、

```
bundle install --path vendor/bundle
```

として必要なライブラリを取得してください。

### hosts ファイル

openIGのgettingstartedには、ブラウザを実行する環境でも以下の記述をhostsファイルに記載するように書かれています。

```
192.168.33.10 www.example.com
```

ただし、確認してみた限りでは、この記載がなくてもIPアドレスでアクセスすれば十分に動作を確認できました。

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

します。

プロキシ対象サーバーの動作
======================

openigのgetting startredでは、プロキシ対象の例として、8081ポートを待ち受ける[executable jarのhttpサーバー](http://192.168.33.10:8081/)を使用します。  
このサーバーにアクセスすると、右上にログインフォームを表示し、その下にOpenIGのドキュメントをiframeで埋め込んだページが表示されます。

このログインフォームにユーザ名: demo, パスワード: changeit を入れてログインすると、ユーザー名とリクエスト内容が記載されたページが表示されます。

このサーバーのインストールと起動設定は[openig-docロール](roles/openig-doc)で行っています。

OpenIGの動作
===========

jettyがサービスとして起動され[8080ポート](http://192.168.33.10:8080/)を待ち受けるように[jettyロール](roles/jetty)でセットアップし、そのルートアプリケーションとして[openig](roles/openig)をデプロイしています。

この[openigサーバー](http://192.168.33.10:8080/)にアクセスすると、リクエストがプロキシ対象サーバーに転送され、その結果をそのまま返します。

この動作を設定しているのは[default](roles/openig-config_for_openig-doc/templates/routes/99-default.json)ルートと[設定ファイルのテンプレート](roles/openig-config_for_openig-doc/templates/config.json)に[変数](roles/openig-config_for_openig-doc/vars/main.yml)を展開した次のような設定です。

```json:handler定義
"handler": {
    "type": "Router",
    "audit": "global",
    "baseURI": "http://www.example.com:8081",
    "capture": "all"
},
```

また、 http://www.example.com:8080/staticにアクセスすると、自動的に`{ "username": [ "demo" ], "password": [ "changeit" ] }`  でログインした結果が表示されます。こちらは、[/static](roles/openig-config_for_openig-doc/templates/routes/01-static.json) routeの設定と上記のhandlerによるものです。
