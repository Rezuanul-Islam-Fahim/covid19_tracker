import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constant.dart';
import '../../../models/covidInfoAll.dart';
import '../../../models/covidInfoCountry.dart';
import 'updateSectionTab.dart';
import 'countrySearch.dart';

class UpdateSection extends StatelessWidget {
  const UpdateSection(
    this.countryName,
    this.covidDataAll,
    this.covidDataCountry,
    this.isLoading,
    this.isSetCountry,
    this.isWrongCountry,
    this.handler,
  );

  final String countryName;
  final CovidInfoAll covidDataAll;
  final CovidInfoCountry covidDataCountry;
  final bool isLoading;
  final bool isSetCountry;
  final bool isWrongCountry;
  final Function handler;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10),
          UpdateSectionTab(countryName),
          SizedBox(height: 3),
          Container(
            height: 260,
            child: TabBarView(
              children: <Widget>[
                UpdateSectionGrid(covidDataAll),
                isSetCountry || countryName != null
                    ? UpdateSectionGrid(covidDataCountry)
                    : CountrySearchForm(
                        handler,
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

class UpdateSectionGrid extends StatelessWidget {
  const UpdateSectionGrid(this.covidData);

  final dynamic covidData;

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.only(top: 15),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        mainAxisExtent: 110,
      ),
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        UpdatePanel(
          title: 'Cases',
          value: covidData.cases,
          color: casesColor,
        ),
        UpdatePanel(
          title: 'New Cases',
          value: covidData.todayCases,
          color: newCasesColor,
        ),
        UpdatePanel(
          title: 'Deaths',
          value: covidData.deaths,
          color: deathsColor,
        ),
        UpdatePanel(
          title: 'New Deaths',
          value: covidData.todayDeaths,
          color: recoveredColor,
        ),
      ],
    );
  }
}

class UpdatePanel extends StatelessWidget {
  const UpdatePanel({this.title, this.value, this.color});

  final String title;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 38,
                height: 38,
                padding: EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: SvgPicture.asset(
                  'assets/icons/running.svg',
                  color: color,
                ),
              ),
              SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headline4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          value != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      value.toString(),
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    SizedBox(height: 4),
                    Text(
                      'People',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ],
                )
              : Container(
                  width: 38,
                  height: 38,
                  padding: EdgeInsets.only(top: 8, left: 8),
                  child: CircularProgressIndicator(),
                ),
        ],
      ),
    );
  }
}
