import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/covidInfoCountry.dart';
import 'countryDataBuilder.dart';
import 'covidDataPanel.dart';

class Search extends SearchDelegate {
  Search(this.covidData);

  final List<CovidInfoCountry> covidData;

  List<CovidInfoCountry> get suggestionList {
    return query.isEmpty
        ? covidData
        : covidData.where((CovidInfoCountry element) {
            return element.countryName!
                .toLowerCase()
                .startsWith(query.trim().toLowerCase());
          }).toList();
  }

  CovidInfoCountry? get resultCountry {
    return covidData.singleWhere((CovidInfoCountry element) {
      return element.countryName!.toLowerCase() == query.trim().toLowerCase();
    }, orElse: () => CovidInfoCountry());
  }

  Widget noResultText(BuildContext context) => Center(
        child: Text(
          'No Results Found',
          style: Theme.of(context).textTheme.headline3,
        ),
      );

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return theme.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: theme.primaryColor,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 12,
        ),
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Color(0xFF0C834D),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.clear, size: 22),
        splashRadius: 13,
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_rounded, size: 28),
      splashRadius: 22,
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (resultCountry!.countryName != null) {
      return SingleChildScrollView(
        child: CovidDataPanel(resultCountry!, true),
      );
    }

    return suggestionList.isNotEmpty
        ? CountryBuilder(suggestionList)
        : noResultText(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return suggestionList.isNotEmpty
        ? CountryBuilder(suggestionList)
        : noResultText(context);
  }
}
