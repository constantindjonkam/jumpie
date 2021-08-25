import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'dart:async';

import '../widgets/Apple.dart';
import '../widgets/AppButton.dart';
import '../widgets/player.dart';
import '../widgets/GamePad.dart';
import '../widgets/Obstacle.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final assetsAudioPlayer = AssetsAudioPlayer.withId("0");
  bool playing = false;

  @override
  void initState() {
    checkCollision();

    assetsAudioPlayer.open(
      Audio("assets/sounds/ForestWalk-320bit.mp3"),
      loopMode: LoopMode.single,
      playInBackground: PlayInBackground.disabledRestoreOnForeground,
    );

    super.initState();
  }

  static double playerX = 0;
  static double playerY = 1;
  double playerSize = 80;
  static double appleX = 0.75;
  static double appleY = 1;
  double appleHeight = 0.7;
  double time = 0;
  double height = 0;
  double initialHeight = 1;
  bool right = true;
  bool midRun = false;
  bool midJump = false;

  bool ateApple() {
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
    if (midJump) return;

    preJump();
    Timer.periodic(Duration(milliseconds: 2), (timer) {
      time += 0.005;
      height = -4.9 * time * time + 5 * time;

      if (initialHeight - height > 1) {
        midJump = false;
        setState(() {
          playerY = 1;
        });
        timer.cancel();
      } else
        setState(() => playerY = initialHeight - height);
    });
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
                  color: Colors.yellow[100],
                  child: AnimatedContainer(
                    alignment: Alignment(playerX, playerY),
                    duration: Duration(milliseconds: 0),
                    child: Player(
                      size: playerSize,
                      right: right,
                      midRun: midRun,
                      midJump: midJump,
                    ),
                  ),
                ),
                Obstacle(-0.8, 0.4),
                Obstacle(0, 0.03),
                Obstacle(-0.75, -0.4),
                Obstacle(0.6, -0.5),
                Apple(appleX, appleY),
                Apple(0.6, -0.75),
                Apple(-0.8, 0.22),
                Apple(0.6, -0.75),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child:
                GamePad(jump: jump, moveLeft: moveLeft, moveRight: moveRight),
          ),
        ],
      ),
    );
  }
}
