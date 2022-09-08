import 'dart:async';

import 'package:flutter/material.dart';

import '../constant.dart';
import '../models/covid_api_handler.dart';
import '../models/covid_info_country.dart';
import '../components/body_loader.dart';
import '../components/covid_data_panel.dart';

class CountryScreen extends StatefulWidget {
  const CountryScreen(this.countryName);

  final String countryName;
  static const String routeName = '/country-screen';

  @override
  _CountryScreenState createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
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

  Future<void> pullToRefresh() async {
    setState(() {
      isLoading = true;
      covidData = CovidInfoCountry();
    });

    loadCovidData();
  }

  @override
  void initState() {
    super.initState();
    loadCovidData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, size: 28),
          splashRadius: 22,
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(widget.countryName),
      ),
      body: isLoading
          ? loader(context)
          : RefreshIndicator(
              color: kPrimaryColor,
              onRefresh: pullToRefresh,
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildListDelegate([
                      CovidDataPanel(covidData),
                    ]),
                  ),
                ],
              ),
            ),
    );
  }
}
