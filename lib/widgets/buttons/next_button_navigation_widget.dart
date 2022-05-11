import 'package:flutter/material.dart';

class NextButtonNavigationWidget extends StatelessWidget {
  NextButtonNavigationWidget({
    this.title,
    required this.onTap, Key? key
  }) : super(key: key);

  String? title;
  Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 57,
        width: 150,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 0.3,
              blurRadius: 4,
              offset: const Offset(0, 5),
            )
          ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Text(title ?? 'Siguiente', style: const TextStyle(color: Colors.white),),
            ),
            const Icon(Icons.chevron_right, color: Colors.white,),
          ],
        ),
      ),
      onTap: onTap(),
    );
  }
}