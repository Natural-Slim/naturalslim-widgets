import 'package:flutter/material.dart';

class PreviousButtonNavigationWidget extends StatelessWidget {
  /// "Back" button. It can be used wherever you need it, be it in paginations, navigations, etc.
  PreviousButtonNavigationWidget({
    this.title,
    required this.onTap, Key? key
  }) : super(key: key);

  String? title;
  Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Ink(
        height: 55,
        width: 142,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 0.3,
              blurRadius: 4,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.chevron_left, color: Theme.of(context).colorScheme.secondary,),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(title ?? 'Anterior', style: TextStyle(color: Theme.of(context).colorScheme.secondary),)
            ),
          ],
        ),
      ),
      onTap: onTap(),
    );
  }
}