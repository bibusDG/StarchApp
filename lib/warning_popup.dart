import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// customized warning popup window

class warningPopUp extends StatelessWidget {
  final String warningText;
  const warningPopUp({
    Key? key,
    required this.warningText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        'WARNING !!!',
        style: TextStyle(
          fontSize: 25.0,
        ),
      ),
      content: Text(warningText),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          child: const Text('Close'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}