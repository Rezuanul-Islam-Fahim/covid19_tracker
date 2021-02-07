import 'package:flutter/material.dart';

class Top5UpdatePanel extends StatelessWidget {
  const Top5UpdatePanel({this.title, this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Colors.grey[50].withOpacity(0.6),
      margin: EdgeInsets.symmetric(horizontal: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 15),
              child: Text(
                title,
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            const SizedBox(height: 10),
            child,
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
