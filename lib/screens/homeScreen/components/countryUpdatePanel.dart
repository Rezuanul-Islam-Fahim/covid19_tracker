import 'package:flutter/material.dart';

import '../../../models/covidInfoCountry.dart';

class CountryUpdatePanel extends StatelessWidget {
  const CountryUpdatePanel(this.covidData, this.title, this.value);

  final CovidInfoCountry covidData;
  final String title;
  final int value;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      splashColor: Colors.grey[200],
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(
                  width: 50,
                  height: 35,
                  child: Image.network(covidData.flag),
                ),
                SizedBox(width: 10),
                Text(
                  covidData.countryName,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
            Text(
              '$title: $value',
              style: TextStyle(
                color: Colors.red,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
