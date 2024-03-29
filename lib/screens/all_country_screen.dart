import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constant.dart';
import '../models/covid_api_handler.dart';
import '../models/covid_info_country.dart';
import '../components/body_loader.dart';
import '../components/country_data_builder.dart';
import '../components/search.dart';
import '../components/drawer.dart';

class AllCountryScreen extends StatefulWidget {
  static String routeName = '/all-country-screen';

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
        title: Text('All Country Data'),
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: SvgPicture.asset(
                'assets/icons/menu.svg',
                width: 23,
                color: Colors.white,
              ),
              splashRadius: 22,
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          },
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
      drawer: MainDrawer(pageIndex: 1),
      body: isLoading
          ? loader(context)
          : RefreshIndicator(
              color: kPrimaryColor,
              onRefresh: pullToRefresh,
              child: CountryBuilder(covidData),
            ),
    );
  }
}
