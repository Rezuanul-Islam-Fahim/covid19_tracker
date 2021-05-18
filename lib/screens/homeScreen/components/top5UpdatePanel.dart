import 'package:flutter/material.dart';

import '../../../models/covidInfoCountry.dart';
import '../../../screens/homeScreen/components/countryPanelLoader.dart';
import '../../countryScreen.dart';

class Top5UpdatePanel extends StatelessWidget {
  const Top5UpdatePanel(
    this.mostEffectionToday,
    this.mostDeathsToday,
    this.mostEffectedCountries,
    this.mostDeaths,
  );

  final List<CovidInfoCountry> mostEffectionToday;
  final List<CovidInfoCountry> mostDeathsToday;
  final List<CovidInfoCountry> mostEffectedCountries;
  final List<CovidInfoCountry> mostDeaths;

  List<Map<String, dynamic>> get panelDetails {
    if (mostEffectionToday.isEmpty ||
        mostDeathsToday.isEmpty ||
        mostEffectedCountries.isEmpty ||
        mostDeaths.isEmpty) {
      return [
        {
          'title': 'Most Effection Today',
          'data': <CovidInfoCountry>[],
        },
        {
          'title': 'Most Deaths Today',
          'data': <CovidInfoCountry>[],
        },
        {
          'title': 'Most Effected Countries',
          'data': <CovidInfoCountry>[],
        },
        {
          'title': 'Most Deaths',
          'data': <CovidInfoCountry>[],
        },
      ];
    }

    return [
      {
        'title': 'Most Effection Today',
        'subtitle': 'Cases',
        'data': mostEffectionToday,
        'values': List.generate(mostEffectionToday.length, (index) {
          return mostEffectionToday[index].todayCases;
        }),
      },
      {
        'title': 'Most Deaths Today',
        'subtitle': 'Deaths',
        'data': mostDeathsToday,
        'values': List.generate(mostDeathsToday.length, (index) {
          return mostDeathsToday[index].todayDeaths;
        }),
      },
      {
        'title': 'Most Effected Countries',
        'subtitle': 'Cases',
        'data': mostEffectedCountries,
        'values': List.generate(mostEffectedCountries.length, (index) {
          return mostEffectedCountries[index].cases;
        }),
      },
      {
        'title': 'Most Deaths',
        'subtitle': 'Deaths',
        'data': mostDeaths,
        'values': List.generate(mostDeaths.length, (index) {
          return mostDeaths[index].deaths;
        }),
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: panelDetails.map((Map<String, dynamic> data) {
        return CountryUpdatePanel(
          title: data['title'],
          subtitle: data['subtitle'],
          data: data['data'],
          values: data['values'],
        );
      }).toList(),
    );
  }
}

class CountryUpdatePanel extends StatelessWidget {
  const CountryUpdatePanel({
    this.title,
    this.subtitle,
    this.data,
    this.values,
  });

  final String title;
  final String subtitle;
  final List<CovidInfoCountry> data;
  final List<int> values;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Colors.grey[50].withOpacity(0.6),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 15),
              child: Text(
                title,
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            const SizedBox(height: 10),
            data.isNotEmpty
                ? Column(
                    children: List.generate(
                      data.length,
                      (int index) {
                        return CountryPanel(
                          data[index],
                          subtitle,
                          values[index],
                        );
                      },
                    ),
                  )
                : countryPanelLoader(),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class CountryPanel extends StatelessWidget {
  const CountryPanel(this.covidData, this.title, this.value);

  final CovidInfoCountry covidData;
  final String title;
  final int value;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        CountryScreen.routeName,
        arguments: covidData.countryName,
      ),
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
