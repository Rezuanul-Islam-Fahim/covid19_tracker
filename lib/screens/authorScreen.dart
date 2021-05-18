import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../components/drawer.dart';

class AuthorScreen extends StatelessWidget {
  static const String routeName = '/author-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Author'),
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: SvgPicture.asset(
                'assets/icons/menu.svg',
                width: 23,
                color: Colors.white,
              ),
              splashRadius: 22,
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          },
        ),
      ),
      drawer: MainDrawer(pageIndex: 3),
      body: Center(child: Text('Author Screen')),
    );
  }
}
