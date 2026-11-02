import 'package:flutter_test/flutter_test.dart';
import 'package:uts_pemmob/app/app.dart';

void main() {
  testWidgets('EFBS app loads successfully', (tester) async {
    await tester.pumpWidget(const EFBSApp());

    expect(find.text('EFBS Prototype'), findsOneWidget);
  });
}