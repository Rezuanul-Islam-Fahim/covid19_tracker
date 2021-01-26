import 'package:flutter/material.dart';

import 'constant.dart';

ThemeData get appTheme => ThemeData(
      scaffoldBackgroundColor: kBackgroundColor,
      appBarTheme: ThemeData.light().appBarTheme.copyWith(
            brightness: Brightness.dark,
          ),
      textTheme: ThemeData.light().textTheme.copyWith(
            headline2: TextStyle(
              color: kTextColor,
              fontSize: 21,
              fontWeight: FontWeight.w700,
            ),
            headline4: TextStyle(
              color: kTextMediumColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            headline5: TextStyle(
              color: kTextLightColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
    );
