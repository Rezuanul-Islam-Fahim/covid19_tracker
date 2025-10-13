import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constant.dart';

ThemeData get appTheme => ThemeData(
      scaffoldBackgroundColor: kBackgroundColor,
      primaryColor: kPrimaryColor,
      appBarTheme: ThemeData.light().appBarTheme.copyWith(
            backgroundColor: kPrimaryColor,
            systemOverlayStyle: SystemUiOverlayStyle.light,
            titleTextStyle: TextStyle(
              fontSize: 19,
            ),
          ),
      textTheme: ThemeData.light().textTheme.copyWith(
            displayMedium: TextStyle(
              color: kTextColor,
              fontSize: 19,
              fontWeight: FontWeight.w700,
            ),
            displaySmall: TextStyle(
              color: kTextMediumColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            headlineMedium: TextStyle(
              color: kTextMediumColor,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
            headlineSmall: TextStyle(
              color: kTextLightColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            titleLarge: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: kPrimaryColor.withValues(alpha: 0.8),
      ),
      listTileTheme: ListTileThemeData(
        selectedColor: kPrimaryColor,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: kPrimaryColor,
      ),
    );
