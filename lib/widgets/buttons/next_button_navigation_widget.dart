import 'package:flutter/material.dart';

class NextButtonNavigationWidget extends StatelessWidget {
  /// "Next" button. It can be used wherever you need it, be it in paginations, navigations, etc.
  NextButtonNavigationWidget({
    this.title,
    required this.onTap, 
    Key? key
  }) : super(key: key);

  String? title;
  Function onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap(),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.secondary),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5)
          )
        ) ,
        shadowColor: MaterialStateProperty.all(Colors.grey.withOpacity(0.3)),
      ),
      child: SizedBox(
        height: 57,
        width: 150,
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
    );
  }
}