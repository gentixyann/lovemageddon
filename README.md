# lovemageddon

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## For iOS Build

```console
$ flutter pub get
$ flutter build ios
```


## For Android Build
Create a `key.properties` file in the `android` directory.
For storePassword and keyPassword, enter the password you entered into the keystore you created.

```properties:android/key.properties
storePassword=your_password
keyPassword=your_password
keyAlias=key0
storeFile=./keystore
```

```console
$ flutter clean
$ flutter build appbundle
```

The aab file will be output to the location `build/app/outputs/bundle/release/`.
