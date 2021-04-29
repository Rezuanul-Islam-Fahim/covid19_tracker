import 'package:flutter/material.dart';

import 'components/body.dart';

class CountryScreen extends StatelessWidget {
  const CountryScreen(this.countryName);

  final String countryName;

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
        title: Text(countryName),
      ),
      body: Body(countryName),
    );
  }
}
