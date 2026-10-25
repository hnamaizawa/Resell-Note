# せどりノート

仕入れ前の利益試算と、商品・在庫・販売実績を記録する日本語Webアプリです。初期版は単一HTMLで動作し、データは利用中のブラウザの `localStorage` に保存します。アカウント間同期や価格サイト連携は行いません。

## 起動方法

WindowsではZIPを展開し、`START_HERE.bat` をダブルクリックしてください。既定のブラウザで起動します。ZIPを使わず `index.html` を直接開いても利用できます。サーバー、インストール、アカウントは不要です。登録データは同じブラウザに保存されるため、CSV出力でバックアップしてください。

アプリ本体は `index.html` だけで完結し、外部APIやインターネット上のフォントを読み込みません。完全オフラインで利用できます。配布用ZIPには起動バッチと日本語の案内を含めます。Windowsの実行ファイル(EXE)ではありません。

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
