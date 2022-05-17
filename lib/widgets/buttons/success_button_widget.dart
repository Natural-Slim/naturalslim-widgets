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
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Text(title),  
      ),
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.symmetric(horizontal: 35)),
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