import 'package:flutter/material.dart';

class SuccessButtonWidget extends StatelessWidget {
  SuccessButtonWidget({
    required this.title,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  String title;
  Function onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(title),
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.symmetric(horizontal: 35, vertical: 15)),
        backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.secondary),
         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
           RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(10),
           )
         )
      ),
      onPressed: () => onPressed(),
    );
  }
}