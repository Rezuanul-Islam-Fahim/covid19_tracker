import 'package:flutter/material.dart';

import '../../../constant.dart';

class CountrySearchForm extends StatelessWidget {
  CountrySearchForm(this.handler, this.isLoading, this.isWrongCountry);

  final Function handler;
  final bool isLoading;
  final bool isWrongCountry;
  final TextEditingController searchController = TextEditingController();

  final ButtonStyle countryButtonStyle = TextButton.styleFrom(
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    backgroundColor: kPrimaryColor.withOpacity(0.9),
  );

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Align(
            alignment: Alignment.center,
            child: Theme(
              data: ThemeData(accentColor: kPrimaryColor),
              child: CircularProgressIndicator(),
            ),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Set country to see your country\'s covid data',
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  errorText:
                      isWrongCountry ? 'Enter a valid country name' : null,
                ),
              ),
              SizedBox(height: 10),
              TextButton.icon(
                icon: Icon(
                  Icons.location_on_rounded,
                  color: Colors.white,
                ),
                style: countryButtonStyle,
                label: Text(
                  'Set Country',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => handler(searchController.text),
              ),
            ],
          );
  }
}
