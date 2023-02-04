# アプリのdockerコンテナを追加


## 構成
以下構成で行う

``` text
pc
|-> docker
　　　|-> nginx
　　　　　　|-> laravel
　　　　　　　　　　|-> mysql
```

今回は最低限のアプリケーションを動作させるためのコンテナをさっと作成してみた。

## 追加ファイル

主にはPR参照

リンク：https://github.com/s-nao/laravel_practice/pull/5

ディレクトリツリー的には

``` text
プロジェクトルート
　　|- .dockerignore 
　　|- Dockerfile
　　|- docker
　　　　　|- nginx
　　　　　|　　|- laravel.conf
　　　　　|
　　　　　|- laravel (追加)
　　　　　　　　|- .env (動作用の環境設定)
　　　　　　　　|- php-8.1.ini
```

今回、プロジェクトルート配下に.dockerignoreをおいたのは、プロジェクトルートにdockerfileがあり、ビルドする際に全てをコピーさせるときにnode_modulesなどあると大きすぎるため、含めないようにするため除外の設定を入れておくのを目的にしている


### nginx

- laravel.conf
  - conf.dに配置する各アプリケーション用のファイル

- php8.1.ini 
  - php.iniは以下をコピーし、エラーを画面に表示する系統はOffにして使っている。
    https://github.com/laradock/laradock/blob/master/php-fpm/php8.1.ini
- .env
  - 元の生成された.envをアプリケーション用に作り替えて、dockerに合わせて動作するように適宜変更する
