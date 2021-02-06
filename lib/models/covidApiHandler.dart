import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'covidInfoAll.dart';
import 'covidInfoCountry.dart';

class CovidHandler {
  static Future<dynamic> getCovidData(String apiUrl, {int fetchLength}) async {
    http.Response response = await http.get(apiUrl);

    return parsedJSON(response.body, fetchLength);
  }

  static dynamic parsedJSON(String response, int fetchLength) {
    dynamic parsedData = json.decode(response);

    if (parsedData is List) {
      List<CovidInfoCountry> covidData = [];

      if (fetchLength == null) {
        parsedData.forEach((dynamic data) {
          covidData.add(CovidInfoCountry.fromJSON(data));
        });
      } else {
        for (int i = 0; i < fetchLength; i++) {
          covidData.add(CovidInfoCountry.fromJSON(parsedData[i]));
        }
      }

      return covidData;
    } else if (parsedData['country'] != null) {
      return CovidInfoCountry.fromJSON(parsedData);
    }

    return CovidInfoAll.fromJSON(parsedData);
  }
}
