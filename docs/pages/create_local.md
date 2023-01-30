---
layout: default
title: ローカル環境設定
---

# 初期設定

## laravelの初期化

[参考：公式インストール方法](https://laravel.com/docs/9.x/installation#your-first-laravel-project)

``` shell
composer create-project laravel/laravel practice
```

### 注意

laravelプロジェクトを作成する際のディレクトリはカレントディレクトリも指定することができるが、からのディレクトリである必要がある。

今回は、アプリ作成後gitのリモート設定を行う

## gitの設定

``` shell
git init
git remote add origin git@github.com:s-nao/laravel_practice.git
git add .
git commit -am "init laravel"
git push origin main --force # 安全に行う場合はブランチを作成する
```

今回は、プロジェクトが空のためmainブランチにforceプッシュしてしまう。
もし、何かアプリケーションが存在している場合は注意して行うこと

## docker composeを使ってDBの作成

### 前提

すでにdockerコマンド並びにdocker composeコマンドが使える前提です

未インストールの場合は以下参考にインストールしてください。

[docker desktopのインストール](https://docs.docker.jp/get-docker.html)

[docker composeのインストール](https://docs.docker.jp/compose/install.html)

### docker composeを使う理由

今回はDBだけなので本来的には必要ないのですが、どのみちあとでアプリケーションのdockerも作るので、docker composeを使っての作成にします。


### 手順


1. プロジェクトルートにdocker-compose.ymlを作成する。
``` yml
version: '3.8'
services:
    mysql:
        image: mysql:8.0.31
        ports:
            - "3306:3306" # ローカル以外で使うなら下手に外部に開けない
        environment:
            TZ: Asia/Tokyo
            MYSQL_RANDOM_ROOT_PASSWORD: yes
            MYSQL_DATABASE: laravel_practice
            MYSQL_USER: app
            MYSQL_PASSWORD: app_user
        volumes:
            - ./docker/db/my.cnf:/etc/mysql/conf.d/my.cnf

```

2.mysqlファイルの設定をする

``` text
プロジェクトルート
|- docker
　　|-db
　　　　|-my.cnf
```

``` text
[mysqld]
character_set_server = utf8mb4
collation_server = utf8mb4_ja_0900_as_cs # 照合順序

[mysql]
default-character-set = utf8mb4

[client]
default-character-set = utf8mb4
```


3.dockerを起動する

```shell
docker compose up -d mysql
```

4.接続確認
```shell
docker compose exec mysql mysql -D laravel_practice -u app -p
# Enter password: と出てくるので「app_user」と入力する
```

## laravelの起動

```shell
php artisan serve 

# ホストを設定したい時 --host ホスト名　デフォルトは127.0.0.1
# ポートを設定したい時 --port ポート番号 8000
```

## DBのマイグレーション

マイグレーションコマンド
```shell
php aritisan migrate
```

マイグレーションの確認

```text
% php artisan migrate:status

  Migration name .................................................................................................................... Batch / Status  
  2014_10_12_000000_create_users_table ..................................................................................................... [1] Ran  
  2014_10_12_100000_create_password_resets_table ........................................................................................... [1] Ran  
  2019_08_19_000000_create_failed_jobs_table ............................................................................................... [1] Ran  
  2019_12_14_000001_create_personal_access_tokens_table .................................................................................... [1] Ran  

```
