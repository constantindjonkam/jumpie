import 'package:flutter/material.dart';

class Apple extends StatelessWidget {
  final double appleX;
  final double appleY;

  Apple(this.appleX, this.appleY);

  @override
  build(BuildContext context) {
    return Container(
      alignment: Alignment(appleX, appleY),
      child: Container(
        width: 35,
        child: Image.asset("assets/images/apple.png"),
      ),
    );
  }
}
