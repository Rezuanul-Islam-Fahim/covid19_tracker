import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constant.dart';
import 'components/updateSection.dart';
import 'components/top5UpdatePanel.dart';
import 'components/mostEffectedCountries.dart';
import 'components/mostDeaths.dart';
import 'components/mostEffectionToday.dart';
import 'components/mostDeathsToday.dart';
import '../allCountryScreen/allCountryScreen.dart';

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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(20, 15, 20, 25),
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.08),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: UpdateSection(),
            ),
            SizedBox(height: 15),
            TextButton(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'All Country Data',
                    style: TextStyle(
                      fontSize: 16,
                      color: kPrimaryColor,
                    ),
                  ),
                  Icon(
                    Icons.arrow_right_alt_rounded,
                    color: kPrimaryColor,
                    size: 28,
                  ),
                ],
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AllCountryScreen()),
              ),
            ),
            SizedBox(height: 15),
            Top5UpdatePanel(
              title: 'Most Effection Today',
              child: MostEffectionToday(),
            ),
            SizedBox(height: 25),
            Top5UpdatePanel(
              title: 'Most Deaths Today',
              child: MostDeathsToday(),
            ),
            SizedBox(height: 25),
            Top5UpdatePanel(
              title: 'Most Effected Countries',
              child: MostEffectedCountries(),
            ),
            SizedBox(height: 25),
            Top5UpdatePanel(
              title: 'Most Deaths',
              child: MostDeaths(),
            ),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
