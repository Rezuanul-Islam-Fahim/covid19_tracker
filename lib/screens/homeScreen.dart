import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constant.dart';
import '../theme.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(20, 50, 20, 25),
            decoration: BoxDecoration(
              color: kPrimaryColor.withOpacity(0.05),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Covid19 Tracker', style: appBarTitle),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: SvgPicture.asset(
                        'assets/icons/menu.svg',
                        width: 23,
                      ),
                      color: kPrimaryColor,
                      splashRadius: 23,
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: SvgPicture.asset(
                        'assets/icons/search.svg',
                        width: 23,
                      ),
                      color: kPrimaryColor,
                      splashRadius: 23,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
