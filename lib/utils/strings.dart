import 'dart:math';

import 'package:intl/intl.dart';

const String kAppName = "Ubenwa";
String generateRandomString(int len) {
  var r = Random();
  return String.fromCharCodes(
      List.generate(len, (index) => r.nextInt(33) + 89));
}

String formatDate({required String date}) {
  return DateFormat("MMM dd, yyyy, HH:mm")
      .format(DateFormat("yyyy-MM-dd'T'HH:mm:ss.Z").parse(date));
}
