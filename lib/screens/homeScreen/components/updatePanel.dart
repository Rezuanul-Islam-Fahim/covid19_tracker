import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UpdatePanel extends StatelessWidget {
  const UpdatePanel(this.covidData);

  final Map<String, dynamic> covidData;

  @override
  Widget build(BuildContext context) {
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
                  color: covidData['color'].withOpacity(0.2),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: SvgPicture.asset(
                  'assets/icons/running.svg',
                  color: covidData['color'],
                ),
              ),
              SizedBox(width: 6),
              Expanded(
                child: Text(
                  covidData['text'],
                  style: Theme.of(context).textTheme.headline4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          Text(
            covidData['value'].toString(),
            style: Theme.of(context).textTheme.headline2,
          ),
          SizedBox(height: 2),
          Text('People'),
        ],
      ),
    );
  }
}
