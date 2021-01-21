import 'package:flutter/material.dart';

import '../../../constant.dart';
import 'updatePanel.dart';

class UpdateSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List data = [
      {
        'color': Colors.orangeAccent,
        'text': 'Total Cases',
        'value': 10540,
      },
      {
        'color': Colors.red,
        'text': 'Total Death',
        'value': 1054,
      },
      {
        'color': Colors.green,
        'text': 'Total Recovered',
        'value': 5550,
      },
      {
        'color': Colors.purple,
        'text': 'New Cases',
        'value': 234,
      },
    ];

    return DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10),
          Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: Container(
              width: 265,
              height: 32,
              child: TabBar(
                unselectedLabelColor: kPrimaryColor,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: kPrimaryColor.withOpacity(0.8),
                ),
                indicatorSize: TabBarIndicatorSize.label,
                indicatorWeight: 0,
                labelPadding: EdgeInsets.symmetric(horizontal: 4),
                tabs: <Widget>[
                  Tab(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: kPrimaryColor.withOpacity(0.4),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('Worldwide'),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: kPrimaryColor.withOpacity(0.4),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('Bangladesh'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 3),
          Container(
            height: 260,
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                GridView(
                  padding: EdgeInsets.only(top: 15),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    mainAxisExtent: 110,
                  ),
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    UpdatePanel(data[0]),
                    UpdatePanel(data[1]),
                    UpdatePanel(data[2]),
                    UpdatePanel(data[3]),
                  ],
                ),
                GridView(
                  padding: EdgeInsets.only(top: 15),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    mainAxisExtent: 110,
                  ),
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    UpdatePanel(data[0]),
                    UpdatePanel(data[1]),
                    UpdatePanel(data[2]),
                    UpdatePanel(data[3]),
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
