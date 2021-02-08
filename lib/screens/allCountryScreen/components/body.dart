import 'dart:async';

import 'package:flutter/material.dart';

import '../../../models/covidInfoCountry.dart';
import '../../../models/covidApiHandler.dart';
import 'countryDataBuilder.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<CovidInfoCountry> covidData;
  bool isLoading = true;

  Future<void> loadCovidData() async {
    covidData = await CovidHandler.getCovidData(
      'https://disease.sh/v3/covid-19/countries',
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
        ? Center(child: CircularProgressIndicator())
        : CountryBuilder(covidData);
  }
}
