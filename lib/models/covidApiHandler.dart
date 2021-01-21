import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'covidInfo.dart';

class CovidHandler {
  static Future<CovidInfo> getCovidData(String apiUrl) async {
    http.Response response = await http.get(apiUrl);

    return parsedJSON(response.body);
  }

  static CovidInfo parsedJSON(String response) {
    Map<String, dynamic> parsedData = json.decode(response);

    return CovidInfo.fromJSON(parsedData);
  }
}
