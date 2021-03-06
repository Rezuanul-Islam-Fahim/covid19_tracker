import 'package:flutter/material.dart';

import 'constant.dart';

ThemeData get appTheme => ThemeData(
      scaffoldBackgroundColor: kBackgroundColor,
      primaryColor: kPrimaryColor,
      accentColor: kPrimaryColor.withOpacity(0.8),
      appBarTheme: ThemeData.light().appBarTheme.copyWith(
            brightness: Brightness.dark,
          ),
      textTheme: ThemeData.light().textTheme.copyWith(
            headline2: TextStyle(
              color: kTextColor,
              fontSize: 19,
              fontWeight: FontWeight.w700,
            ),
            headline3: TextStyle(
              color: kTextMediumColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            headline4: TextStyle(
              color: kTextMediumColor,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
            headline5: TextStyle(
              color: kTextLightColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            headline6: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
    );
