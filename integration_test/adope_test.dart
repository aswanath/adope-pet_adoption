import 'package:adope/main.dart' as adope;
import 'package:adope/modules/home/screen/home_screen.dart';
import 'package:adope/modules/home/widget/home_search_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

//small example for integration testing

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("home screen test", () {
    testWidgets(
      "Checking the basic functionalities in the home screen only",
      (tester) async {
        adope.main();
        await tester.pumpAndSettle(const Duration(seconds: 5));
        expect(find.byKey(const Key(petTileKey)), findsWidgets);

        final searchFieldFinder = find.byKey(const Key(homeSearchFieldKey));
        expect(searchFieldFinder, findsOneWidget);
        await tester.enterText(searchFieldFinder, 'Bruce');
        await tester.testTextInput.receiveAction(TextInputAction.search);
        await tester.pump();

        expect(find.byKey(const Key(petTileKey)), findsOneWidget);

        final clearButtonFinder = find.byKey(const Key(searchFieldClearButtonKey));
        expect(clearButtonFinder, findsOneWidget);
        await tester.tap(clearButtonFinder);
        await tester.pump();
        expect(find.byKey(const Key(petTileKey)), isNot(findsOneWidget));
        expect(find.byKey(const Key(petTileKey)), findsWidgets);
      },
    );
  });
}
