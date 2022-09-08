class CovidInfoAll {
  final int? cases;
  final int? todayCases;
  final int? deaths;
  final int? todayDeaths;
  final int? recovered;
  final int? todayRecovered;

  CovidInfoAll({
    this.cases,
    this.todayCases,
    this.deaths,
    this.todayDeaths,
    this.recovered,
    this.todayRecovered,
  });

  factory CovidInfoAll.fromJSON(Map<String, dynamic> covidData) {
    return CovidInfoAll(
      cases: covidData['cases'],
      todayCases: covidData['todayCases'],
      deaths: covidData['deaths'],
      todayDeaths: covidData['todayDeaths'],
      recovered: covidData['recovered'],
      todayRecovered: covidData['todayRecovered'],
    );
  }
}
