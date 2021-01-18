import 'package:flutter/material.dart';

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

    return Container(
      child: GridView(
        shrinkWrap: true,
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
    );
  }
}
