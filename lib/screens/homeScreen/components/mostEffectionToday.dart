import 'dart:async';

import 'package:flutter/material.dart';

import '../../../models/covidInfoCountry.dart';
import '../../../models/covidApiHandler.dart';
import 'countryUpdatePanel.dart';
import 'countryPanelLoader.dart';

class MostEffectionToday extends StatefulWidget {
  @override
  _MostEffectionTodayState createState() => _MostEffectionTodayState();
}

class _MostEffectionTodayState extends State<MostEffectionToday> {
  List<CovidInfoCountry> covidData;
  bool isLoading = true;

  Future<void> loadCovidData() async {
    covidData = await CovidHandler.getCovidData(
      Uri.parse('https://disease.sh/v3/covid-19/countries?sort=todayCases'),
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
                  'New Cases',
                  covidData[index].todayCases,
                );
              },
            ),
          );
  }
}
