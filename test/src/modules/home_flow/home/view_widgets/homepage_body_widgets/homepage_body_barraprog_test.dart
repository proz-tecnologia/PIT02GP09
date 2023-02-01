import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/modules/home_flow/home/view_widgets/homepage_body_widgets/homepage_body_barraprog.dart';

void main () {
  testWidgets(
    'testing HomePageProgBar',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const Material(
          child: HomePageProgBar(currentValue: 50, planning: 100),
        ),
      );
      
      final progbar = tester.widget<HomePageProgBar>(find.byType(HomePageProgBar));

      expect(progbar.currentValue, 50);
      expect(find.byType(Expanded), findsOneWidget);
    },
  );
}