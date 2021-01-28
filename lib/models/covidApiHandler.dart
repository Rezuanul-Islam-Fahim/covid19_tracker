import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'covidInfo.dart';

class CovidHandler {
  static Future<dynamic> getCovidData(String apiUrl) async {
    http.Response response = await http.get(apiUrl);

    return parsedJSON(response.body);
  }

  static dynamic parsedJSON(String response) {
    dynamic parsedData = json.decode(response);

    if (parsedData is List) {
      List<CovidInfo> covidData = [];

      parsedData.forEach((dynamic data) {
        covidData.add(CovidInfo.fromJSON(data));
      });

      return covidData;
    }

    return CovidInfo.fromJSON(parsedData);
  }
}
