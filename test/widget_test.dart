import 'package:court_click_task/main.dart';
import 'package:court_click_task/screens/splash_screen.dart';
import 'package:court_click_task/utils/dependency_injection.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App renders splash screen', (WidgetTester tester) async {
    await setupLocator();
    await tester.pumpWidget(const CourtClickApp());
    expect(find.byType(SplashScreen), findsOneWidget);
    await tester.pump(const Duration(seconds: 3));
  });
}
