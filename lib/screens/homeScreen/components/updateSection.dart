import 'dart:async';

import 'package:flutter/material.dart';

import '../../../constant.dart';
import '../../../models/covidInfo.dart';
import '../../../models/covidApiHandler.dart';
import 'updatePanel.dart';

class UpdateSection extends StatefulWidget {
  @override
  _UpdateSectionState createState() => _UpdateSectionState();
}

class _UpdateSectionState extends State<UpdateSection> {
  CovidInfo covidData = CovidInfo();

  Future<void> loadCovidData() async {
    covidData =
        await CovidHandler.getCovidData('https://disease.sh/v3/covid-19/all');
    setState(() {});
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
          Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: Container(
              width: 265,
              height: 32,
              child: TabBar(
                unselectedLabelColor: kPrimaryColor,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: kPrimaryColor.withOpacity(0.8),
                ),
                indicatorSize: TabBarIndicatorSize.label,
                indicatorWeight: 0,
                labelPadding: EdgeInsets.symmetric(horizontal: 4),
                tabs: <Widget>[
                  Tab(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: kPrimaryColor.withOpacity(0.4),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('Worldwide'),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: kPrimaryColor.withOpacity(0.4),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('Bangladesh'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 3),
          Container(
            height: 260,
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                GridView(
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
                      title: 'Deaths',
                      value: covidData.deaths,
                      color: deathsColor,
                    ),
                    UpdatePanel(
                      title: 'New Deaths',
                      value: covidData.todayDeaths,
                      color: recoveredColor,
                    ),
                    UpdatePanel(
                      title: 'New Cases',
                      value: covidData.todayCases,
                      color: newCasesColor,
                    ),
                  ],
                ),
                GridView(
                  padding: EdgeInsets.only(top: 15),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    mainAxisExtent: 110,
                  ),
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    // UpdatePanel(data[0]),
                    // UpdatePanel(data[1]),
                    // UpdatePanel(data[2]),
                    // UpdatePanel(data[3]),
                    Text('rgegrg'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
