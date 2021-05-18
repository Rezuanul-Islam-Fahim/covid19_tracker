import 'package:flutter/material.dart';

import '../screens/allCountryScreen.dart';
import '../screens/authorScreen.dart';
import '../screens/settingScreen.dart';
import '../screens/homeScreen/homeScreen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({this.pageIndex});

  final int pageIndex;

  List<Map<String, dynamic>> get menuList {
    return [
      {
        'title': Text('Home'),
        'icon': Icon(Icons.home_rounded),
        'navigation': HomeScreen.routeName,
      },
      {
        'title': Text('All Country Data'),
        'icon': Icon(Icons.ac_unit_rounded),
        'navigation': AllCountryScreen.routeName,
      },
      {
        'title': Text('Settings'),
        'icon': Icon(Icons.settings_rounded),
        'navigation': SettingScreen.routeName,
      },
      {
        'title': Text('About Author'),
        'icon': Icon(Icons.info),
        'navigation': AuthorScreen.routeName,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          CustomPaint(
            painter: ShapePainter(context),
            child: SizedBox(
              width: double.infinity,
              height: 135,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 18),
                  Text(
                    'Covid19 Tracker',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Get latest Covid19 updates',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Column(
            children: List.generate(menuList.length, (int index) {
              return ListTile(
                leading: menuList[index]['icon'],
                title: menuList[index]['title'],
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 3,
                ),
                minLeadingWidth: 10,
                dense: true,
                selected: pageIndex == index ? true : false,
                onTap: () {
                  Navigator.pop(context);
                  if (pageIndex != index) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      menuList[index]['navigation'],
                      menuList[index]['navigation'] != HomeScreen.routeName
                          ? ModalRoute.withName(HomeScreen.routeName)
                          : (Route<dynamic> route) => false,
                    );
                  }
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

class ShapePainter extends CustomPainter {
  const ShapePainter(this.context);

  final BuildContext context;
  final double kCurveHeight = 30;

  @override
  void paint(Canvas canvas, Size size) {
    final Path path = Path();
    path.lineTo(0, size.height - kCurveHeight);
    path.relativeQuadraticBezierTo(
      size.width / 2,
      2 * kCurveHeight,
      size.width,
      0,
    );
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(
      path,
      Paint()..color = Theme.of(context).primaryColor,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
