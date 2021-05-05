import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/covidApiHandler.dart';
import '../models/covidInfoCountry.dart';
import '../components/bodyLoader.dart';
import '../components/countryDataBuilder.dart';
import '../components/search.dart';

class AllCountryScreen extends StatefulWidget {
  @override
  _AllCountryScreenState createState() => _AllCountryScreenState();
}

class _AllCountryScreenState extends State<AllCountryScreen> {
  List<CovidInfoCountry> covidData = [];
  bool isLoading = true;

  Future<void> loadCovidData() async {
    covidData = await CovidHandler.getCovidData(
      Uri.parse('https://disease.sh/v3/covid-19/countries'),
    );
    isLoading = false;
    setState(() {});
  }

  Future<void> pullToRefresh() async {
    setState(() {
      isLoading = true;
      covidData = [];
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
        automaticallyImplyLeading: false,
        title: Text('All Country Data'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, size: 28),
          splashRadius: 22,
          onPressed: () => Navigator.pop(context),
        ),
        actions: <Widget>[
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/search.svg',
              width: 22,
              color: Colors.white,
            ),
            splashRadius: 22,
            onPressed: () => showSearch(
              context: context,
              delegate: Search(covidData),
            ),
          ),
        ],
      ),
      body: isLoading
          ? loader(context)
          : RefreshIndicator(
              onRefresh: pullToRefresh,
              child: CountryBuilder(covidData),
            ),
    );
  }
}
