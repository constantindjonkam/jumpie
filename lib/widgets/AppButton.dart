import 'package:flutter/material.dart';

var index = 0;

class AppButton extends StatelessWidget {
  final child;
  final onTapDown;
  static bool holdingBtn = false;

  AppButton({this.child, this.onTapDown});
  bool isButtonHeld() => holdingBtn;

  @override
  build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        holdingBtn = true;
        onTapDown();
      },
      // onTapCancel: () => holdingBtn = false,
      onTapUp: (_) {
        holdingBtn = false;
        index++;
        print("key up: " + index.toString());
      },
      child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            padding: EdgeInsets.all(12),
            color: Colors.brown[300],
            child: child,
          )),
    );
  }
}
