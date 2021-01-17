import 'package:flutter/material.dart';

import './constant.dart';

ThemeData get appTheme => ThemeData(
      scaffoldBackgroundColor: kBackgroundColor,
    );

TextStyle get appBarTitle => TextStyle(
      color: kPrimaryColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
