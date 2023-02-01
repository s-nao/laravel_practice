# アプリのdockerコンテナを追加


## 構成
以下構成で行う

``` text
pc ー> (19000)docker内 (19000と9000を対応させる)
　　　　　|
　　　　　|-> (9000)laravel -> mysql
```

※本来はnginxとかを挟んだ構成が正しいのかもしれないが、今回は最低限のアプリケーションを動作させる（はず・・）のdockerコンテナを作成する

## 追加ファイル

主にはPR参照

リンク：https://github.com/s-nao/laravel_practice/pull/5

ディレクトリツリー的には

``` text
プロジェクトルート
　　|-.dockerignore 
　　|- docker
　　　　　|
　　　　　|-laravel (追加)
　　　　　　　　|
　　　　　　　　|- .env (動作用の環境設定)

```

今回、プロジェクトルートはいかに.dockerignoreをおいたのは、プロジェクトルートにdockerfileがあり、ビルドする際に全てをコピーさせるときにnode_modulesなどあると大きすぎるため、含めないようにするため除外の設定を入れておくのを目的にしている
