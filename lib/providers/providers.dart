import 'package:flutter_riverpod/flutter_riverpod.dart';

// 参加人数
final numberProvider = StateProvider<int?>((ref) {
  return 5;
});

// 女性参加者の名前
final womanNameProvider = StateProvider<List<String>>((ref) {
  return [];
});
