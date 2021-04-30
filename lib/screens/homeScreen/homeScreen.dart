import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constant.dart';
import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Covid19 Tracker'),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/menu.svg',
            width: 23,
            color: Colors.white,
          ),
          splashRadius: 22,
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/search.svg',
              width: 21,
              color: Colors.white,
            ),
            splashRadius: 22,
            onPressed: () {},
          ),
        ],
      ),
      body: Body(),
    );
  }
}
