import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant.dart';
import '../../components/search.dart';
import '../../components/drawer.dart';
import '../../models/covidApiHandler.dart';
import '../../models/covidInfoAll.dart';
import '../../models/covidInfoCountry.dart';
import '../allCountryScreen.dart';
import 'components/top5UpdatePanel.dart';
import 'components/updateSection.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String countryName;
  CovidInfoAll covidDataAll = CovidInfoAll();
  CovidInfoCountry covidDataCountry = CovidInfoCountry();
  List<CovidInfoCountry> sortedCountryData = [];
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

    sortedCountryData = await CovidHandler.getCovidData(
      Uri.parse('https://disease.sh/v3/covid-19/countries'),
    );

    setState(() {});
  }

  Future<void> loadPanelData1() async {
    mostEffectionToday = await CovidHandler.getCovidData(
      Uri.parse(
        'https://disease.sh/v3/covid-19/countries?sort=todayCases',
      ),
      fetchLength: 5,
    );

    setState(() {});
  }

  Future<void> loadPanelData2() async {
    mostDeathsToday = await CovidHandler.getCovidData(
      Uri.parse(
        'https://disease.sh/v3/covid-19/countries?sort=todayDeaths',
      ),
      fetchLength: 5,
    );

    setState(() {});
  }

  Future<void> loadPanelData3() async {
    mostEffectedCountries = await CovidHandler.getCovidData(
      Uri.parse(
        'https://disease.sh/v3/covid-19/countries?sort=cases',
      ),
      fetchLength: 5,
    );

    setState(() {});
  }

  Future<void> loadPanelData4() async {
    mostDeaths = await CovidHandler.getCovidData(
      Uri.parse(
        'https://disease.sh/v3/covid-19/countries?sort=deaths',
      ),
      fetchLength: 5,
    );

    setState(() {});
  }

  Future<void> pullToRefresh() async {
    setState(() {
      covidDataAll = CovidInfoAll();
      covidDataCountry = CovidInfoCountry();
      mostEffectionToday = [];
      mostDeathsToday = [];
      mostEffectedCountries = [];
      mostDeaths = [];
    });

    loadCovidData();
    loadPanelData1();
    loadPanelData2();
    loadPanelData3();
    loadPanelData4();
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
          Uri.parse(
            'https://disease.sh/v3/covid-19/countries/$countryName',
          ),
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
    loadPanelData1();
    loadPanelData2();
    loadPanelData3();
    loadPanelData4();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Covid19 Tracker'),
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
              width: 21,
              color: Colors.white,
            ),
            splashRadius: 22,
            onPressed: () => showSearch(
              context: context,
              delegate: Search(sortedCountryData),
            ),
          ),
        ],
      ),
      drawer: MainDrawer(pageIndex: 0),
      body: RefreshIndicator(
        onRefresh: pullToRefresh,
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
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
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
                    onPressed: () => Navigator.pushNamed(
                      context,
                      AllCountryScreen.routeName,
                    ),
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
      ),
    );
  }
}
