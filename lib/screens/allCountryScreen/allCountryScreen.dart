import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AllCountryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('All Country Data'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, size: 28),
          splashRadius: 21,
          onPressed: () => Navigator.pop(context),
        ),
        actions: <Widget>[
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/search.svg',
              width: 21,
              color: Colors.white,
            ),
            splashRadius: 22,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
