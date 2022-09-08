import 'package:flutter/material.dart';

import '../../../constant.dart';

class UpdateSectionTab extends StatelessWidget {
  const UpdateSectionTab(this.countryName);

  final String? countryName;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: Container(
        width: 265,
        height: 32,
        child: TabBar(
          unselectedLabelColor: kPrimaryColor,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: kPrimaryColor.withOpacity(0.8),
          ),
          indicatorSize: TabBarIndicatorSize.label,
          indicatorWeight: 0,
          labelPadding: EdgeInsets.symmetric(horizontal: 4),
          tabs: <Widget>[
            Tab(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: kPrimaryColor.withOpacity(0.4),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text('Worldwide'),
                ),
              ),
            ),
            Tab(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: kPrimaryColor.withOpacity(0.4),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    countryName == null ? 'My Country' : countryName!,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
