import 'dart:async';

import 'package:flutter/material.dart';

import '../../../models/covidInfoCountry.dart';
import '../../../models/covidApiHandler.dart';
import 'covidDataPanel.dart';

class Body extends StatefulWidget {
  Body(this.countryName);

  final String countryName;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  CovidInfoCountry covidData = CovidInfoCountry();
  bool isLoading = true;

  Future<void> loadCovidData() async {
    covidData = await CovidHandler.getCovidData(
      Uri.parse(
        'https://disease.sh/v3/covid-19/countries/${widget.countryName}',
      ),
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
        ? Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(width: 10),
                Text(
                  'Loading...',
                  style: Theme.of(context).textTheme.headline3,
                ),
              ],
            ),
          )
        : SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 10),
                  Center(
                    child: SizedBox(
                      width: 120,
                      child: Image.network(covidData.flag),
                    ),
                  ),
                  SizedBox(height: 25),
                  CovidDataPanel(covidData),
                  SizedBox(height: 20),
                ],
              ),
            ),
          );
  }
}
