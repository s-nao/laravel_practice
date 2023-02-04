# 認証機能

基本的には、laravel breezeを使って行う。

公式のstarter kitを参考にしてわからないところを検索しつつ進めていく。

参考：https://laravel.com/docs/9.x/starter-kits

## 準備

ライブラリインストール

```shell
composer require laravel/breeze --dev
```

今回は、vueやreactを使うわけではないので、以下のコマンドで行う。

```shell
php artisan breeze:install blade
php artisan migrate
```
公式ではbladeの引数を入れていないためか、npm installがコマンドで書かれているが、今回のコマンドで実行した際のログでは、以下のように出ておりnpm install時のログなど出ているため、そのままマイグレーションして問題ないと考えている。

```text
laravel_practice % php artisan breeze:install blade

   INFO  Installing and building Node dependencies.  

--- この辺からnpm install
added 66 packages, and audited 95 packages in 11s

20 packages are looking for funding
  run `npm fund` for details

found 0 vulnerabilities

----npm installが終了

--- この辺からnpm run build

> build
> vite build

vite v4.0.4 building for production...
✓ 51 modules transformed.
public/build/manifest.json              0.26 kB
public/build/assets/app-f52d8432.css   26.35 kB │ gzip:  5.27 kB
public/build/assets/app-22da05bb.js   141.73 kB │ gzip: 52.20 kB

--- npm run buildの終了

   INFO  Breeze scaffolding installed successfully.  

```

また、git statusをするとわかるが、この時点で複数のファイルがインストールされている。


## 実行

通常のアプリケーション同様に以下で起動できる。

```shell
php artisan serve
```

[アプリケーション用のdocker作成](./setting_docker.md)のdockerを使っても確認するところができる。

```shell
# 全て動いている場合
docker compose up -d laravel --build

# 動いてない場合

docker compose build laravel
docker compose up -d
```

---

## 追記

今回の変更でビルドされた静的ファイルができたので、nginx側に配置する必要ができてきた。

そのため、以下2つのファイルに変更を加えた。

nginxはおそらく本来このような設定でないと、他のパスに移動したときにうまくいかなかったと想定される。


- docker-compose.yml

``` yaml
version: '3.8'
services:
    nginx:
        image: nginx:latest
        ports:
            - "18080:8080"
        volumes:
            - ./docker/nginx/conf.d:/etc/nginx/conf.d
            - ./public:/var/www/public # 追加
        depends_on:
            - laravel
```

- nginx conf

``` 
access_log /dev/stdout main;
error_log /dev/stderr warn;

server {
    listen 8080;

    root /var/www/public;

    location / {
        try_files $uri $uri/ /index.php$is_args$args;
    }

    location ~ \.php$ {
        fastcgi_split_path_info ^(.+\.php)(\.+)$;
        fastcgi_pass laravel:9000;
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param PATH_INFO $fastcgi_path_info;
    }
}
```
