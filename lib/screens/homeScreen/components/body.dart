import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constant.dart';
import '../../../models/covidApiHandler.dart';
import '../../../models/covidInfoAll.dart';
import '../../../models/covidInfoCountry.dart';
import '../../../screens/allCountryScreen/allCountryScreen.dart';
import 'top5UpdatePanel.dart';
import 'updateSection.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String countryName;
  CovidInfoAll covidDataAll = CovidInfoAll();
  CovidInfoCountry covidDataCountry = CovidInfoCountry();
  List<CovidInfoCountry> mostEffectionToday = [];
  List<CovidInfoCountry> mostDeathsToday = [];
  List<CovidInfoCountry> mostEffectedCountries = [];
  List<CovidInfoCountry> mostDeaths = [];
  bool isLoading = false;
  bool isSetCountry = false;
  bool isWrongCountry = false;

  Future<void> loadCovidData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('countryName')) {
      setState(() => countryName = prefs.getString('countryName'));
    }

    covidDataAll = await CovidHandler.getCovidData(
      Uri.parse('https://disease.sh/v3/covid-19/all'),
    );

    if (prefs.containsKey('countryName')) {
      covidDataCountry = await CovidHandler.getCovidData(
        Uri.parse(
          'https://disease.sh/v3/covid-19/countries/${countryName.toLowerCase()}',
        ),
      );
    }

    setState(() {});

    mostEffectionToday = await CovidHandler.getCovidData(
      Uri.parse('https://disease.sh/v3/covid-19/countries?sort=todayCases'),
      fetchLength: 5,
    );
    mostDeathsToday = await CovidHandler.getCovidData(
      Uri.parse('https://disease.sh/v3/covid-19/countries?sort=todayDeaths'),
      fetchLength: 5,
    );
    mostEffectedCountries = await CovidHandler.getCovidData(
      Uri.parse('https://disease.sh/v3/covid-19/countries?sort=cases'),
      fetchLength: 5,
    );
    mostDeaths = await CovidHandler.getCovidData(
      Uri.parse('https://disease.sh/v3/covid-19/countries?sort=deaths'),
      fetchLength: 5,
    );

    setState(() {});
  }

  Future<void> setCountry(String countryName) async {
    if (countryName.isNotEmpty) {
      setState(() => isLoading = true);

      List<CovidInfoCountry> covidAllCountryData =
          await CovidHandler.getCovidData(
        Uri.parse('https://disease.sh/v3/covid-19/countries'),
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
          Uri.parse('https://disease.sh/v3/covid-19/countries/$countryName'),
        );
        countryName = covidDataCountry.countryName;
        setState(() {});
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('countryName', countryName);
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
    return RefreshIndicator(
      onRefresh: () {},
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                padding: EdgeInsets.fromLTRB(20, 15, 20, 25),
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.08),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: UpdateSection(
                  countryName,
                  covidDataAll,
                  covidDataCountry,
                  isLoading,
                  isSetCountry,
                  isWrongCountry,
                  setCountry,
                ),
              ),
              SizedBox(height: 15),
              TextButton(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'All Country Data',
                      style: TextStyle(
                        fontSize: 16,
                        color: kPrimaryColor,
                      ),
                    ),
                    Icon(
                      Icons.arrow_right_alt_rounded,
                      color: kPrimaryColor,
                      size: 28,
                    ),
                  ],
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AllCountryScreen()),
                ),
              ),
              SizedBox(height: 10),
              Top5UpdatePanel(
                mostEffectionToday,
                mostDeathsToday,
                mostEffectedCountries,
                mostDeaths,
              ),
              SizedBox(height: 15),
            ]),
          ),
        ],
      ),
    );
  }
}
