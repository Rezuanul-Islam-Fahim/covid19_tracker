import 'package:flutter/material.dart';

import '../../../models/covidInfo.dart';
import '../../../constant.dart';
import 'updatePanel.dart';

class UpdateSectionGrid extends StatelessWidget {
  const UpdateSectionGrid(this.covidData);

  final CovidInfo covidData;

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.only(top: 15),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        mainAxisExtent: 110,
      ),
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        UpdatePanel(
          title: 'Cases',
          value: covidData.cases,
          color: casesColor,
        ),
        UpdatePanel(
          title: 'New Cases',
          value: covidData.todayCases,
          color: newCasesColor,
        ),
        UpdatePanel(
          title: 'Deaths',
          value: covidData.deaths,
          color: deathsColor,
        ),
        UpdatePanel(
          title: 'New Deaths',
          value: covidData.todayDeaths,
          color: recoveredColor,
        ),
      ],
    );
  }
}
