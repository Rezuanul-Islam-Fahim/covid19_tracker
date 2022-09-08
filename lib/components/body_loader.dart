import 'package:flutter/material.dart';

Widget loader(BuildContext context) {
  return Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        SizedBox(width: 10),
        Text(
          'Loading...',
          style: Theme.of(context).textTheme.headline3,
        ),
      ],
    ),
  );
}
