import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      height: 260,
      child: GridView.builder(
        padding: EdgeInsets.only(top: 15),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          mainAxisExtent: 110,
        ),
        physics: NeverScrollableScrollPhysics(),
        itemCount: 4,
        itemBuilder: (BuildContext context, index) {
          return Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 38,
                      height: 38,
                      padding: EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        color: data[index]['color'].withOpacity(0.2),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/running.svg',
                        color: data[index]['color'],
                      ),
                    ),
                    SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        data[index]['text'],
                        style: Theme.of(context).textTheme.headline4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Text(
                  data[index]['value'].toString(),
                  style: Theme.of(context).textTheme.headline2,
                ),
                SizedBox(height: 2),
                Text(
                  'People',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
