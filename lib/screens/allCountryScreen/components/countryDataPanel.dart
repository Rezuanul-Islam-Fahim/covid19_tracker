import 'package:flutter/material.dart';

import '../../../models/covidInfoCountry.dart';
import '../../../screens/countryScreen/countryScreen.dart';

class CountryDataPanel extends StatelessWidget {
  const CountryDataPanel(this.covidData);

  final CovidInfoCountry covidData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CountryScreen(covidData.countryName),
        ),
      ),
      splashColor: Colors.grey[200],
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 50,
                    height: 45,
                    child: Image.network(covidData.flag),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      covidData.countryName,
                      style: Theme.of(context).textTheme.headline4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 20),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                Text(
                  'Cases: ${covidData.cases} (+${covidData.todayCases})',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Deaths: ${covidData.deaths} (+${covidData.todayDeaths})',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
