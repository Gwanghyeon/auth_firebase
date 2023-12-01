import 'package:authentification_firebase/models/custom_error.dart';
import 'package:flutter/cupertino.dart';

void showErrorDialog(BuildContext context, CustomError e) {
  showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Text(e.code),
      content: Text(e.plugin + '\n' + e.message),
      actions: [
        CupertinoDialogAction(
          child: Text('OK'),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    ),
  );
}
