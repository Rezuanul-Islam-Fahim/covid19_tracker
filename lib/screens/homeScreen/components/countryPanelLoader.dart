import 'package:flutter/material.dart';

import '../../../constant.dart';

Container countryPanelLoader() => Container(
      alignment: Alignment.center,
      height: 100,
      child: Theme(
        data: ThemeData(accentColor: kPrimaryColor),
        child: CircularProgressIndicator(),
      ),
    );
