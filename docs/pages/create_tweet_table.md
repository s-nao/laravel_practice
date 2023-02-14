## テーブル作成

1.マイグレーションファイルの作成

```shell
php artisan make:migration create_tweets_table
```

もしモデルファイルと同時に作成する場合
```shell
php artisan make:model Tweet --migration
```

上記コマンドを打つと以下のようなファイルが生成されています。

``` text
./
|-databases
　　　|-migrations
　　　　　　|-2023_02_12_063112_create_tweets_table.php
```

ファイルの中身は、マイグレーションを進めるときのupとロールバックする時のdownが記載されています。

デフォルトは、idと挿入した時のtimestampsが記載されています。

自分が追加したいフィールドをこの中に記載していきます。

``` injectablephp
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('tweets', function (Blueprint $table) {
            $table->id();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('tweets');
    }
};

```

2.マイグレーションファイルに書き込む

抜粋
```injectablephp
    public function up()
    {
        Schema::create('tweets', function (Blueprint $table) {
            $table->id();
            $table->text("message");
            $table->timestamps();
        });
    }
```

フィールドの型がわからないときはこちらをみながら参考にしました

https://readouble.com/laravel/9.x/ja/migrations.html

3.マイグレーションの実施

``` shell
php artisan migrate
```

テーブル一覧を出すとテーブルが出来ていることを確認

- データベースに直接見る場合

``` text
mysql> show tables;
+----------------------------+
| Tables_in_laravel_practice |
+----------------------------+
| failed_jobs                |
| migrations                 |
| password_resets            |
| personal_access_tokens     |
| tweets                     |
| users                      |
+----------------------------+
6 rows in set (0.01 sec)
```

- artisanで見る場合

コマンド
``` shell
 php artisan migrate:status 
```

出力
```
  Migration name .................................................................................................................... Batch / Status  
  2014_10_12_000000_create_users_table ..................................................................................................... [1] Ran  
  2014_10_12_100000_create_password_resets_table ........................................................................................... [1] Ran  
  2019_08_19_000000_create_failed_jobs_table ............................................................................................... [1] Ran  
  2019_12_14_000001_create_personal_access_tokens_table .................................................................................... [1] Ran  
  2023_02_12_063112_create_tweets_table ..................................................................................................... [2] Ran
```
