import 'dart:async';

import 'package:flutter/material.dart';

import '../../../models/covidInfoCountry.dart';
import '../../../models/covidApiHandler.dart';
import 'countryUpdatePanel.dart';
import 'countryPanelLoader.dart';

class MostDeathsToday extends StatefulWidget {
  @override
  _MostDeathsTodayState createState() => _MostDeathsTodayState();
}

class _MostDeathsTodayState extends State<MostDeathsToday> {
  List<CovidInfoCountry> covidData;
  bool isLoading = true;

  Future<void> loadCovidData() async {
    covidData = await CovidHandler.getCovidData(
      Uri.parse('https://disease.sh/v3/covid-19/countries?sort=todayDeaths'),
      fetchLength: 5,
    );
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadCovidData();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? countryPanelLoader()
        : Column(
            children: List.generate(
              covidData.length,
              (int index) {
                return CountryUpdatePanel(
                  covidData[index],
                  'New Deaths',
                  covidData[index].todayDeaths,
                );
              },
            ),
          );
  }
}
