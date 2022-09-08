import 'package:flutter/material.dart';

import 'theme.dart';
import 'screens/home_screen/home_screen.dart';
import 'screens/all_country_screen.dart';
import 'screens/country_screen.dart';
import 'screens/author_screen.dart';
import 'screens/setting_screen.dart';

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
          CountryScreen.routeName: (_) => CountryScreen(
                settings.arguments.toString(),
              ),
        };
        WidgetBuilder? builder = routes[settings.name];

        return MaterialPageRoute(builder: (context) => builder!(context));
      },
    );
  }
}
