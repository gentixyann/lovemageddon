import 'package:flutter_riverpod/flutter_riverpod.dart';

final numberProvider = StateProvider<int?>((ref) {
  // 変化するデータ
  return 5;
});
