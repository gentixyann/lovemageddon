# lovemageddon

## 開発環境

Flutter 3.50.1 stable（`.flutter-version`）を使用します。iOS の最低対応バージョンは 15.0 です。インストール済みの Flutter は `flutter --version` で確認できます。

```sh
flutter pub get
flutter analyze
flutter test
```

## ストアへのビルドアップロード

`make release` は iOS の IPA と Android の AAB を作成し、TestFlight と Google Play の内部テストトラックに順にアップロードします。App Store の審査提出や一般公開は行いません。内部テストの公開・配信設定は Play Console 側の設定に従います。

### 初回準備

1. macOS、Xcode、Ruby/Bundler、Flutter 3.50.1、Android SDK を用意し、`make release-setup` を実行します。
2. Xcode で Apple Developer アカウント、チーム、配布用証明書とプロビジョニングを設定します。App Store Connect に `com.motemagedon.app` のアプリを作成します。
3. Android のアップロード鍵を用意し、`android/key.properties` に署名情報を設定します。`storeFile` は `android/app` からの相対パス、または絶対パスです。

   ```properties
   storePassword=your_password
   keyPassword=your_password
   keyAlias=key0
   storeFile=../your-upload-key.jks
   ```

4. App Store Connect API のキー ID・Issuer ID・`.p8` ファイルを用意します。Google Play Developer API を有効にし、Play Console でアプリへの権限を付与したサービスアカウントの JSON キーを用意します。Google Play の初回アプリ登録や必要なストア情報は事前に Console で完了してください。
5. 認証情報をシェルに設定します。鍵ファイルはリポジトリ外に保管してください。

   ```sh
   export APP_STORE_CONNECT_KEY_ID='YOUR_KEY_ID'
   export APP_STORE_CONNECT_ISSUER_ID='YOUR_ISSUER_ID'
   export APP_STORE_CONNECT_KEY_PATH='/absolute/path/to/AuthKey.p8'
   export GOOGLE_PLAY_JSON_KEY_PATH='/absolute/path/to/google-play-service-account.json'
   ```

### アップロード

`pubspec.yaml` の `version`（例: `1.1.1+11`）を更新してください。ビルド番号は両ストアで既存のものより大きい値が必要です。

```sh
make release
```

両方のビルドが成功した後、iOS、Android の順にアップロードします。後半で失敗した場合、先にアップロードされた iOS のビルドは残ります。ログを確認し、ストア側の状態に応じてビルド番号を更新して再実行してください。TestFlight の処理完了は待機しません。

認証・権限の詳細は [App Store Connect API](https://docs.fastlane.tools/app-store-connect-api/) と [Google Play へのアップロード](https://docs.fastlane.tools/actions/upload_to_play_store/) を参照してください。
