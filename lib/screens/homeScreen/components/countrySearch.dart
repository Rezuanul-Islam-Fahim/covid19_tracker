import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constant.dart';

class CountrySearchForm extends StatelessWidget {
  CountrySearchForm(this.handler, this.isLoading, this.isWrongCountry);

  final Function handler;
  final bool isLoading;
  final bool isWrongCountry;
  final TextEditingController searchController = TextEditingController();

  final ButtonStyle countryButtonStyle = TextButton.styleFrom(
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 13),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    backgroundColor: kPrimaryColor.withOpacity(0.8),
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
        : Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: SvgPicture.asset(
                  'assets/icons/map.svg',
                  width: double.infinity,
                ),
              ),
              Column(
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
                            color: Colors.grey[400],
                            width: 0.6,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.grey[500],
                            width: 0.6,
                          ),
                        ),
                        filled: true,
                        fillColor: kBackgroundColor.withOpacity(0.6),
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
                    onPressed: () => handler(
                      searchController.text.trim().toLowerCase(),
                    ),
                  ),
                ],
              ),
            ],
          );
  }
}
