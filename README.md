# せどりノート

仕入れ前の利益試算と、商品・在庫・販売実績を記録する日本語Webアプリです。初期版は単一HTMLで動作し、データは利用中のブラウザの `localStorage` に保存します。アカウント間同期や価格サイト連携はまだ行いません。

## 起動方法

`index.html` をブラウザで開いてください。仕入れ候補を試算し、商品名を入力して保存できます。CSV出力で登録内容をバックアップできます。

## 開発ハーネス

開発時の要求、ガードレール、受け入れ基準は [`harness/`](harness/) を参照してください。ブラウザ依存を最小限にするため、純粋な利益計算ルールは `harness/acceptance.md` に明記しています。変更を提出する前に `scripts/verify.sh` を実行してください。

## GitHub連携

この作業環境では GitHub コネクタの読み書きは利用できますが、新しいリポジトリを作成する操作とローカル作業ツリーへの clone/push 機能は見つかりませんでした。GitHub 上の新規リポジトリを作成後、次のように接続できます。

```sh
git init -b main
git add .
git commit -m "Initial sedori note app"
git remote add origin https://github.com/<owner>/sedori-note.git
git push -u origin main
```

実装は小さな変更単位でPRに分け、Actionsでハーネス確認後にマージしてください。
