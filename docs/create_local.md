# 初期設定

## laravelの初期化

[参考：公式インストール方法](https://laravel.com/docs/9.x/installation#your-first-laravel-project)

```$shell
composer create-project laravel/laravel ディレクトリ名
```

### 注意

laravelプロジェクトを作成する際のディレクトリはカレントディレクトリも指定することができるが、からのディレクトリである必要がある。

今回は、アプリ作成後gitのリモート設定を行う

## gitの設定

```$shell
git init
git remote add origin git@github.com:s-nao/laravel_practice.git
git add .
git commit -am "init laravel"
git push origin main --force
```

今回は、プロジェクトが空のためmainブランチにforceプッシュしてしまう。
もし、何かアプリケーションが存在している場合は注意して行うこと
