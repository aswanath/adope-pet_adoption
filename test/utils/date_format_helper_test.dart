import 'package:adope/utils/date_format_helper.dart';
import 'package:flutter_test/flutter_test.dart';

//unit testing example
void main() {
  group("date format testing", () {
    test(
      "passing all the needed date parameters",
      () {
        String result = formatDate(DateTime(2003, 1, 11));
        expect(result, "Jan 11");
      },
    );

    test(
      "passing all the needed date parameters with wrong date",
      () {
        String result = formatDate(DateTime(2003, 1, 40));
        expect(result, isNot("Jan 40"));
      },
    );

    test(
      "not passing day",
      () {
        String result = formatDate(DateTime(2003, 1));
        expect(result, "Jan 1");
      },
    );

    test(
      "only passing year",
      () {
        String result = formatDate(DateTime(2003));
        expect(result, "Jan 1");
      },
    );
  });
}
