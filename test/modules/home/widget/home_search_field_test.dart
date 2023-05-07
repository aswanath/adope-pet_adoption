import 'package:adope/modules/home/widget/home_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

//widget test example
void main() {
  group("testing Home Search Field", () {
    testWidgets(
      "doing the search callback",
      (tester) async {
        final TextEditingController textEditingController = TextEditingController();
        String? searchText;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: HomeSearchField(
                textEditingController: textEditingController,
                onSearched: (val) {
                  searchText = val;
                },
              ),
            ),
          ),
        );

        await tester.pump();
        final searchFieldFinder = find.byKey(const Key(homeSearchFieldKey));
        expect(searchFieldFinder, findsOneWidget);

        //confirm initial states
        expect(textEditingController.text, '');
        expect(searchText, null);

        await tester.enterText(searchFieldFinder, '');
        await tester.testTextInput.receiveAction(TextInputAction.search);

        //confirm empty searchText
        expect(textEditingController.text, '');
        expect(searchText, '');

        await tester.enterText(searchFieldFinder, 'search');
        await tester.testTextInput.receiveAction(TextInputAction.search);
        await tester.pump();

        //confirm valid searchText and clear button
        expect(textEditingController.text, 'search');
        expect(searchText, 'search');
        final clearButtonFinder = find.byKey(const Key(searchFieldClearButtonKey));
        expect(clearButtonFinder, findsOneWidget);

        await tester.tap(clearButtonFinder);
        await tester.pump();

        //confirm text field is clearing when clicking on clear button
        expect(textEditingController.text, '');
        expect(searchText, '');
      },
    );
  });
}
