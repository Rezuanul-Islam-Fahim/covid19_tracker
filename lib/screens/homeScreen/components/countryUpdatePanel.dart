import 'package:flutter/material.dart';

import '../../../constant.dart';
import '../../../models/covidInfoCountry.dart';

class CountryUpdatePanel extends StatelessWidget {
  const CountryUpdatePanel(this.covidData, this.isLoading);

  final List<CovidInfoCountry> covidData;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
            alignment: Alignment.center,
            height: 100,
            child: Theme(
              data: ThemeData(accentColor: kPrimaryColor),
              child: CircularProgressIndicator(),
            ),
          )
        : Column(
            children: List.generate(covidData.length, (int index) {
              return InkWell(
                onTap: () {},
                splashColor: Colors.grey[300],
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 55,
                            height: 35,
                            child: Image.network(covidData[index].flag),
                          ),
                          SizedBox(width: 10),
                          Text(
                            covidData[index].countryName,
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ],
                      ),
                      Text(
                        'Cases: ${covidData[index].cases}',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          );
  }
}
