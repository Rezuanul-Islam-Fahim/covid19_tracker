import 'package:flutter/material.dart';

import '../models/covidApiHandler.dart';
import '../models/covidInfoCountry.dart';
import '../components/covidDataPanel.dart';

class CountryScreen extends StatefulWidget {
  const CountryScreen(this.countryName);

  final String countryName;

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
          : CovidDataPanel(covidData),
    );
  }
}
