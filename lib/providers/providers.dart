import 'package:flutter_riverpod/flutter_riverpod.dart';

// 参加人数
final numberProvider = StateProvider<int>((ref) {
  return 3;
});

// 女性参加者の名前
final womanNameProvider = StateProvider<List<String>>((ref) {
  return [];
});

// 男性参加者の名前
final manNameProvider = StateProvider<List<String>>((ref) {
  return [];
});

// 女性参加者の選んだ相手
final womanSelectedProvider = StateProvider<Map<String, String?>>((ref) {
  return {};
});

// 男性参加者の選んだ相手
final manSelectedProvider = StateProvider<Map<String, String?>>((ref) {
  return {};
});
