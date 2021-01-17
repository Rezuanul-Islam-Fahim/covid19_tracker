import 'package:flutter/material.dart';

import './constant.dart';

ThemeData get appTheme => ThemeData(
      scaffoldBackgroundColor: kBackgroundColor,
      textTheme: ThemeData.light().textTheme.copyWith(
            headline2: TextStyle(
              color: kTextColor,
              fontSize: 21,
              fontWeight: FontWeight.w700,
            ),
            headline4: TextStyle(
              color: kTextMediumColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
    );

TextStyle get appBarTitle => TextStyle(
      color: kPrimaryColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
