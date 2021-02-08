import 'package:flutter/material.dart';

import '../../../constant.dart';

Container countryPanelLoader() => Container(
      alignment: Alignment.center,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(width: 10),
          Text(
            'Loading...',
            style: TextStyle(
              color: kTextMediumColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
