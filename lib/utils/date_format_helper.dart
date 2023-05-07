import 'package:intl/intl.dart';

String formatDate(DateTime dateTime) {
  return DateFormat('MMM d').format(dateTime);
}
