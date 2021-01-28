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
              Container(
                height: 50,
                child: TextFormField(
                  controller: searchController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 25),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey[350],
                        width: 0.7,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey[400],
                        width: 0.9,
                      ),
                    ),
                    filled: true,
                    fillColor: kBackgroundColor,
                    hintText: 'Enter Country Name',
                  ),
                ),
              ),
              if (isWrongCountry)
                Container(
                  padding: EdgeInsets.only(top: 5, left: 2),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Enter a valid country name',
                    style: TextStyle(color: Colors.red, fontSize: 15),
                  ),
                ),
              SizedBox(height: 15),
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
