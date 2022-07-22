import 'package:flutter/material.dart';

class Snackbars{
  static void showSnackbarSuccess(BuildContext context, {required String title}){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content:
        Row(
          children: [
            Icon(Icons.check_circle, color: Theme.of(context).colorScheme.primary,),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(title),
            )
          ],
        )
      )
    );
  }

  static void showSnackbarError(BuildContext context, {required String title}){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content:
        Row(
          children: [
            Icon(Icons.cancel, color: Theme.of(context).colorScheme.error,),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(title),
            )
          ],
        )
      )
    );
  }
}