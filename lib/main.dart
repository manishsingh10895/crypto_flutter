import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'pages/home.page.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.teal,
        primaryColor: defaultTargetPlatform == TargetPlatform.iOS ? Colors.grey[100]: null
      ),
      home: new HomePage()
    );
  }
}