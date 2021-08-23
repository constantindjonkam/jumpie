import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './screens/Home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    SystemChrome.setEnabledSystemUIOverlays([]);

    return MaterialApp(
      home: Home(),
    );
  }
}
