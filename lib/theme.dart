import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constant.dart';

ThemeData get appTheme => ThemeData(
      scaffoldBackgroundColor: kBackgroundColor,
      primaryColor: kPrimaryColor,
      appBarTheme: ThemeData.light().appBarTheme.copyWith(
            backgroundColor: kPrimaryColor,
            systemOverlayStyle: SystemUiOverlayStyle.light,
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
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: kPrimaryColor.withOpacity(0.8),
      ),
      listTileTheme: ListTileThemeData(
        selectedColor: kPrimaryColor,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: kPrimaryColor,
      ),
    );
