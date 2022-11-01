
import 'package:flutter/material.dart';

showSingleTextInputDialog({
  required BuildContext context,
  required String title,
  String positiveButtonText = 'OK',
  String negativeButtonText = 'CLOSE',
  required Function(String) onSubmit,
}) {
  final txtController = TextEditingController();
  showDialog(context: context, builder: (context) => AlertDialog(
    title: Text(title),
    content: Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        controller: txtController,
        decoration: InputDecoration(
          labelText: 'Enter $title',
        ),
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text(negativeButtonText),
      ),
      TextButton(
        onPressed: () {
          if(txtController.text.isEmpty) return;
          onSubmit(txtController.text);
          Navigator.pop(context);
        },
        child: Text(positiveButtonText),
      )
    ],
  ));
}