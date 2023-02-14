

### 作成したもの

``` text
./
|-app
|　|- Http
|　|　　|- Controllers
|　|　　　　　|- TweetController.php
|　|- Models　
|　　　　|- Tweet.php
|- resoures
|　　|- views
|　　　　|- list.blade.php　
|- routes
　　 |-web.app (編集)
```

#### modelファイルの作成

``` shell
php artisan make:model Tweet
```

### 追加したファイル
- Controllers
  - TweetController
- Models
  - Tweet.php
- views
  - list.blade.php

### データの投入

```sql
insert into tweets(message, created_at, updated_at) VALUES ("test", NOW(), NOW());
```


### 画面の確認

ローカルサーバーの立ち上げ

``` shell
php artisan serve
```

あとは画面を表示してログインしてみてください。
その後、以下ページを表示すると、データが出ていることが確認できます。

http://127.0.0.1:8000/tweets


