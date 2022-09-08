import 'package:flutter/material.dart';

import '../models/covidInfoCountry.dart';

class CovidDataPanel extends StatelessWidget {
  const CovidDataPanel(this.covidData, [this.isTitle = false]);

  final CovidInfoCountry covidData;
  final bool isTitle;

  Map<String, dynamic> get covidDataMap {
    return {
      'Continent': covidData.continent,
      'Population': covidData.population,
      'Cases': covidData.cases,
      'TodayCases': covidData.todayCases,
      'Deaths': covidData.deaths,
      'TodayDeaths': covidData.todayDeaths,
      'Recovered': covidData.recovered,
      'TodayRecovered': covidData.todayRecovered,
      'Active': covidData.active,
      'Critical': covidData.critical,
      'CasesPerOneMillion': covidData.casesPerOneMillion,
      'DeathsPerOneMillion': covidData.deathsPerOneMillion,
      'Tests': covidData.tests,
      'TestsPerOneMillion': covidData.testsPerOneMillion,
      'OneCasePerPeople': covidData.oneCasePerPeople,
      'OneDeathPerPeople': covidData.oneDeathPerPeople,
      'OneTestPerPeople': covidData.oneTestPerPeople,
      'ActivePerOneMillion': covidData.activePerOneMillion,
      'RecoveredPerOneMillion': covidData.recoveredPerOneMillion,
      'CriticalPerOneMillion': covidData.criticalPerOneMillion,
    };
  }

  Widget buildCovidDataPanel(BuildContext context) {
    List<Widget> covidBlock = [];

    covidDataMap.forEach((key, value) {
      covidBlock.add(
        Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  key,
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(value.toString()),
              ],
            ),
            if (key != 'CriticalPerOneMillion')
              Column(
                children: <Widget>[
                  SizedBox(height: 5),
                  Divider(
                    color: Colors.grey[400],
                  ),
                  SizedBox(height: 5),
                ],
              ),
          ],
        ),
      );
    });

    return Column(children: covidBlock);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 10),
          Center(
            child: SizedBox(
              width: 120,
              child: Image.network(covidData.flag!),
            ),
          ),
          isTitle
              ? Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  child: Text(
                    covidData.countryName!,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                )
              : SizedBox(height: 25),
          Card(
            elevation: 4,
            shadowColor: Colors.grey[50],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Text(
                    'Covid-19 Details',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  SizedBox(height: 30),
                  buildCovidDataPanel(context),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
