import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:lovemageddon/features/choice_men/choice_men_screen.dart';
import 'package:lovemageddon/features/choice_woman/choice_woman_screen.dart';
import 'package:lovemageddon/providers/providers.dart';

void main() {
  for (final screen in [const ChoiceMenScreen(), const ChoiceWomanScreen()]) {
    testWidgets('${screen.runtimeType}: 次の参加者は選び直す', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            numberProvider.overrideWith((ref) => 2),
            womanNameProvider.overrideWith((ref) => ['女性1', '女性2']),
            manNameProvider.overrideWith((ref) => ['男性1', '男性2']),
          ],
          child: MaterialApp(home: screen),
        ),
      );
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();
      final choice = screen is ChoiceMenScreen ? '男性1' : '女性1';
      await tester.tap(find.text(choice).last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('次へ'));
      await tester.pumpAndSettle();
      expect(find.text('誰が良い？'), findsOneWidget);
      await tester.tap(find.text('次へ'));
      await tester.pumpAndSettle();
      expect(find.text('お相手を選んでね！'), findsOneWidget);
    });
  }
}
