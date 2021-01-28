import 'dart:async';

import 'package:flutter/material.dart';

import '../../../models/covidInfo.dart';
import '../../../models/covidApiHandler.dart';
import 'updateGrid.dart';
import 'tabBar.dart';
import 'countrySearch.dart';

class UpdateSection extends StatefulWidget {
  @override
  _UpdateSectionState createState() => _UpdateSectionState();
}

class _UpdateSectionState extends State<UpdateSection> {
  CovidInfo covidDataAll = CovidInfo();
  CovidInfo covidDataCountry = CovidInfo();
  bool isLoading = false;
  bool isSetCountry = false;
  bool isWrongCountry = false;

  Future<void> loadCovidData() async {
    covidDataAll = await CovidHandler.getCovidData(
      'https://disease.sh/v3/covid-19/all',
    );
    setState(() {});
  }

  Future<void> setCountry(String countryName) async {
    setState(() => isLoading = true);

    List<CovidInfo> covidAllCountryData = await CovidHandler.getCovidData(
      'https://disease.sh/v3/covid-19/countries',
    );

    setState(() {
      for (CovidInfo data in covidAllCountryData) {
        if (data.countryName.toLowerCase() == countryName.toLowerCase()) {
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
      setState(() {});
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
          UpdateSectionTab(covidDataCountry.countryName),
          SizedBox(height: 3),
          Container(
            height: 260,
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                UpdateSectionGrid(covidDataAll),
                isSetCountry
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
