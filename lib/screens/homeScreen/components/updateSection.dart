import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/covidInfoAll.dart';
import '../../../models/covidInfoCountry.dart';
import '../../../models/covidApiHandler.dart';
import 'updateGrid.dart';
import 'tabBar.dart';
import 'countrySearch.dart';

class UpdateSection extends StatefulWidget {
  @override
  _UpdateSectionState createState() => _UpdateSectionState();
}

class _UpdateSectionState extends State<UpdateSection> {
  CovidInfoAll covidDataAll = CovidInfoAll();
  CovidInfoCountry covidDataCountry = CovidInfoCountry();
  String country;
  bool isLoading = false;
  bool isSetCountry = false;
  bool isWrongCountry = false;

  Future<void> loadCovidData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('countryName')) {
      setState(() => country = prefs.getString('countryName'));
    }

    covidDataAll = await CovidHandler.getCovidData(
      'https://disease.sh/v3/covid-19/all',
    );

    if (prefs.containsKey('countryName')) {
      covidDataCountry = await CovidHandler.getCovidData(
        'https://disease.sh/v3/covid-19/countries/${country.toLowerCase()}',
      );
    }

    setState(() {});
  }

  Future<void> setCountry(String countryName) async {
    if (countryName.isNotEmpty) {
      setState(() => isLoading = true);

      List<CovidInfoCountry> covidAllCountryData =
          await CovidHandler.getCovidData(
        'https://disease.sh/v3/covid-19/countries',
      );

      setState(() {
        for (CovidInfoCountry data in covidAllCountryData) {
          if (data.countryName.toLowerCase() == countryName) {
            isSetCountry = true;
            break;
          }
        }

        if (!isSetCountry) isWrongCountry = true;
        isLoading = false;
      });

      if (isSetCountry) {
        covidDataCountry = await CovidHandler.getCovidData(
          'https://disease.sh/v3/covid-19/countries/$countryName',
        );
        country = covidDataCountry.countryName;
        setState(() {});
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('countryName', country);
      }
    } else {
      setState(() => isWrongCountry = true);
    }
  }

  @override
  void initState() {
    super.initState();
    loadCovidData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10),
          UpdateSectionTab(country),
          SizedBox(height: 3),
          Container(
            height: 260,
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                UpdateSectionGrid(covidDataAll),
                isSetCountry || country != null
                    ? UpdateSectionGrid(covidDataCountry)
                    : CountrySearchForm(
                        setCountry,
                        isLoading,
                        isWrongCountry,
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
