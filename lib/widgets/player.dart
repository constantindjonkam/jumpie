import 'package:flutter/material.dart';
import 'dart:math';

class Player extends StatelessWidget {
  final bool right;
  final midRun;
  final midJump;
  final size;

  Player(
      {required this.right,
      required this.midRun,
      required this.midJump,
      required this.size});

  @override
  build(BuildContext context) {
    Image playerAction() {
      if (midJump)
        return Image.asset("assets/images/Jump3.png");
      else if (midRun) return Image.asset("assets/images/Idle1.png");
      return Image.asset("assets/images/Walk1.png");
    }

    return Container(
      // width: size,
      height: size,
      child: right
          ? playerAction()
          : Transform(
              transform: Matrix4.rotationY(pi),
              alignment: Alignment.center,
              child: playerAction(),
            ),
    );
  }
}
