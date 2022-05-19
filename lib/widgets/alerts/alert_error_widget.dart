import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AlertErrorWidget extends StatelessWidget {
  const AlertErrorWidget({
    Key? key,
    this.errorCode,
    this.message,
    required this.title,
  }) : super(key: key);
  
  final String? errorCode;
  final String? message;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 200.0,
            maxWidth: 500.0
          ),
          child: Column(
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 200.0,
                  maxHeight: 180.0,
                ),
                child: SvgPicture.asset("lib/assets/svgs/Error.svg", package: "naturalslim_widgets",)
              ),
              if(errorCode != null) Text(
                errorCode!,
                style: const TextStyle(
                  fontSize: 96,
                  color: Colors.red,
                  fontWeight: FontWeight.bold
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: errorCode != null ? 0.0 : 16.0),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              if(message != null) Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  message!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}