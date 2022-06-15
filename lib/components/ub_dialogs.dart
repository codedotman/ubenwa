import 'package:flutter/material.dart';

class UBDialogs {
  static Future<void> showSnackBar(String text, BuildContext context,
      {required GlobalKey<ScaffoldState> key,
      SnackBarAction? action,
      Color? textColor,
      Color? backgroundColor,
      bool success = true,
      Duration duration = const Duration(milliseconds: 1800)}) async {
    // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //   content: Text("Not Eklendi"),
    //   duration: Duration(seconds: 2),
    // ))

    final snackBar = SnackBar(
      content: SizedBox(
        width: MediaQuery.of(context).size.height * 0.40,
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      duration: duration,
      backgroundColor: Colors.black,
      action: action,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    // if (key != null) {
    //   key.currentState!.showSnackBar(snackBar);
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // }
  }
}
