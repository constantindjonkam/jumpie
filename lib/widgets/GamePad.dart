import 'package:flutter/material.dart';

import './AppButton.dart';

class GamePad extends StatelessWidget {
  final void Function() moveLeft;
  final void Function() moveRight;
  final void Function() jump;

  GamePad(
      {required this.moveLeft, required this.moveRight, required this.jump});

  @override
  build(BuildContext context) {
    return Container(
      child: Container(
        color: Colors.brown,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: AppButton(
                        child: Icon(Icons.arrow_back, color: Colors.white),
                        onTapDown: moveLeft),
                  ),
                  AppButton(
                      child: Icon(Icons.arrow_forward, color: Colors.white),
                      onTapDown: moveRight),
                ],
              ),
              AppButton(
                  child: Icon(Icons.arrow_upward, color: Colors.white),
                  onTapDown: jump),
            ],
          ),
        ),
      ),
    );
  }
}
