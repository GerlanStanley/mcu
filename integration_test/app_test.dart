import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:mcu/main.dart' as app;

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    "Alternar entre filmes e verificar se mudou os dados do filme",
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      final movieItemComponent = find.byKey(const Key("movie_1"));
      await tester.tap(movieItemComponent);

      await tester.pumpAndSettle();

      var textWidget =
          find.byKey(const Key("movie_title")).evaluate().single.widget as Text;

      final text = textWidget.data;

      expect(text, "CAPITÃ MARVEL");
    },
  );
}
