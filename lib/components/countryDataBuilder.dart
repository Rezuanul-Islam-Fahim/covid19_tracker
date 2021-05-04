import 'package:flutter/material.dart';

import '../models/covidInfoCountry.dart';
import 'countryDataPanel.dart';

class CountryBuilder extends StatelessWidget {
  const CountryBuilder(this.covidData);

  final List<CovidInfoCountry> covidData;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: covidData.length,
      itemBuilder: (BuildContext context, int index) {
        if (index + 1 < covidData.length) {
          return Column(
            children: <Widget>[
              CountryDataPanel(covidData[index]),
              Divider(
                color: Colors.black26,
                height: 0,
              ),
            ],
          );
        }
        return CountryDataPanel(covidData[index]);
      },
    );
  }
}
