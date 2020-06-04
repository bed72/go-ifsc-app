import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';

import 'package:go_ifsc/app/modules/login/login_page.dart';

main() {
  testWidgets('LoginPage has title', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(LoginPage()));
    final titleFinder = find.text('Login');
    expect(titleFinder, findsOneWidget);
  });
}
