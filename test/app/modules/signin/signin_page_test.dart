import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';

import 'package:go_ifsc/app/modules/signin/signin_page.dart';

main() {
  testWidgets('SigninPage has title', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(SigninPage()));
    final titleFinder = find.text('Signin');
    expect(titleFinder, findsOneWidget);
  });
}
