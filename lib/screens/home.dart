import 'package:flutter/material.dart';
import 'dart:async';

import '../widgets/Apple.dart';
import '../widgets/AppButton.dart';
import '../widgets/player.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    checkCollision();
    super.initState();
  }

  static double playerX = 0;
  static double playerY = 1;
  double playerSize = 80;
  static double appleX = 0.75;
  static double appleY = 1;
  static double appleHeight = 0.7;
  double time = 0;
  double height = 0;
  double initialHeight = playerY;
  bool right = true;
  bool midRun = false;
  bool midJump = false;

  bool ateApple() {
    // print('position apple: (${appleX.toString()}, ${appleY.toString()})');
    // print('position player: (${playerX.toString()}, ${playerY.toString()})');

    if (((playerX - appleX).abs() < 0.07 && (playerY - appleY).abs() < 0.07) ||
        ((playerX - appleX).abs() < 0.07 && playerY > appleHeight && midJump)) {
      setState(() {
        appleX = 2;
        playerSize = 120;
        print("big");
      });

      return true;
    }

    return false;
  }

  void checkCollision() {
    Timer.periodic(new Duration(milliseconds: 10), (timer) {
      final res = ateApple();

      if (res)
        Timer.periodic(
          Duration(seconds: 5),
          (_timer) => setState(() {
            appleX = 0.5;
            playerSize = 80;
            _timer.cancel();
          }),
        );
    });
  }

  void preJump() {
    time = 0;
    initialHeight = playerY;
    midJump = true;
  }

  void jump() {
    // if (midJump) return;

    // preJump();
    // Timer.periodic(Duration(milliseconds: 2), (timer) {
    //   time += 0.005;
    //   height = -4.9 * time * time + 5 * time;

    //   if (initialHeight - height > 1) {
    //     midJump = false;
    //     setState(() {
    //       playerY = 1;
    //     });
    //     timer.cancel();
    //   }
    // setState(() => playerY = initialHeight - height);
    // });
  }

  void moveRight() {
    right = true;
    midRun = !midRun;

    Timer.periodic(Duration(milliseconds: 50), (timer) {
      if (AppButton.holdingBtn && (playerX + 0.02) < 1)
        setState(() {
          playerX += 0.02;
          midRun = !midRun;
        });
      else
        timer.cancel();
    });
  }

  void moveLeft() {
    right = false;
    midRun = !midRun;

    Timer.periodic(Duration(milliseconds: 50), (timer) {
      if (AppButton.holdingBtn && (playerX - 0.02) > -1)
        setState(() {
          playerX -= 0.02;
          midRun = !midRun;
        });
      else
        timer.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 4,
              child: Stack(
                children: [
                  Container(
                      color: Colors.blue,
                      child: AnimatedContainer(
                        alignment: Alignment(playerX, playerY),
                        duration: Duration(milliseconds: 0),
                        child: Player(
                            size: playerSize,
                            right: right,
                            midRun: midRun,
                            midJump: midJump),
                      )),
                  Apple(appleX, appleY),
                ],
              )),
          Expanded(
              flex: 1,
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
                                child:
                                    Icon(Icons.arrow_back, color: Colors.white),
                                onTapDown: moveLeft),
                          ),
                          AppButton(
                              child: Icon(Icons.arrow_forward,
                                  color: Colors.white),
                              onTapDown: moveRight),
                        ],
                      ),
                      AppButton(
                        child: Icon(Icons.arrow_upward, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
