import 'package:flutter/material.dart';

import 'theme.dart';
import 'screens/homeScreen/homeScreen.dart';
import 'screens/allCountryScreen.dart';
import 'screens/countryScreen.dart';
import 'screens/authorScreen.dart';
import 'screens/settingScreen.dart';

void main() => runApp(CovidTracker());

class CovidTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid19 Tracker',
      theme: appTheme,
      initialRoute: HomeScreen.routeName,
      routes: <String, WidgetBuilder>{
        HomeScreen.routeName: (_) => HomeScreen(),
        AllCountryScreen.routeName: (_) => AllCountryScreen(),
        SettingScreen.routeName: (_) => SettingScreen(),
        AuthorScreen.routeName: (_) => AuthorScreen(),
      },
      onGenerateRoute: (RouteSettings settings) {
        Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
          CountryScreen.routeName: (_) => CountryScreen(settings.arguments),
        };
        WidgetBuilder builder = routes[settings.name];

        return MaterialPageRoute(builder: (context) => builder(context));
      },
    );
  }
}
