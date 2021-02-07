import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UpdatePanel extends StatelessWidget {
  const UpdatePanel({this.title, this.value, this.color});

  final String title;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 38,
                height: 38,
                padding: EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: SvgPicture.asset(
                  'assets/icons/running.svg',
                  color: color,
                ),
              ),
              SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headline4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          value != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      value.toString(),
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    SizedBox(height: 4),
                    Text(
                      'People',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ],
                )
              : Container(
                  width: 38,
                  height: 38,
                  padding: EdgeInsets.only(top: 8, left: 8),
                  child: CircularProgressIndicator(),
                ),
        ],
      ),
    );
  }
}
