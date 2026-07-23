// アプリが例外なく起動・描画できることを確認する smoke テスト。
//
// このアプリは flutter_riverpod を使用するため、ルートを ProviderScope で
// ラップしてから MyApp をポンプする。

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lovemageddon/main.dart';

void main() {
  testWidgets('アプリがクラッシュせず起動する', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MyApp(firstLaunch: false),
      ),
    );
    await tester.pump();

    // MaterialApp が構築されていること（＝起動できたこと）を検証する。
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
