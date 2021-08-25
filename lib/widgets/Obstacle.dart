import 'package:flutter/material.dart';

class Obstacle extends StatelessWidget {
  final double obstacleX;
  final double obstacleY;

  Obstacle(this.obstacleX, this.obstacleY);

  @override
  build(BuildContext context) {
    return Container(
      alignment: Alignment(obstacleX, obstacleY),
      child: Container(
        color: Colors.brown,
        width: 200,
        height: 20,
      ),
    );
  }
}
