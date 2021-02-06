import 'dart:async';

import 'package:flutter/material.dart';

import '../../../models/covidInfoCountry.dart';
import '../../../models/covidApiHandler.dart';
import 'countryUpdatePanel.dart';

class MostEffectedCountries extends StatefulWidget {
  @override
  _MostEffectedCountriesState createState() => _MostEffectedCountriesState();
}

class _MostEffectedCountriesState extends State<MostEffectedCountries> {
  List<CovidInfoCountry> covidData;
  bool isLoading = true;

  Future<void> loadCovidData() async {
    covidData = await CovidHandler.getCovidData(
      'https://disease.sh/v3/covid-19/countries?sort=cases',
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
    return CountryUpdatePanel(covidData, isLoading);
  }
}
