import 'package:flutter/material.dart';

class Loading{

  /// It displays an icon that simulates an indefinite load. Displays a CircularProgressIndicator in the middle of the screen.
  static Future showLoad(BuildContext context){
    return showDialog(
      context: context, 
      barrierColor: Theme.of(context).colorScheme.background.withOpacity(0.2),
      barrierDismissible: false,
      builder: (context) => Container(
        height: 100,
        width: 100,
        alignment: Alignment.center,
        margin: const EdgeInsets.all(20),
        child: const CircularProgressIndicator(),
      )
    );
  }
}