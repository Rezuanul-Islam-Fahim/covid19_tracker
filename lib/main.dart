import 'package:flutter/material.dart';

import 'theme.dart';
import 'screens/homeScreen/homeScreen.dart';

void main() => runApp(CovidTracker());

class CovidTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid19 Tracker',
      theme: appTheme,
      home: HomeScreen(),
    );
  }
}
