class CovidInfo {
  final String countryName;
  final int cases;
  final int todayCases;
  final int deaths;
  final int todayDeaths;
  final int recovered;
  final int todayRecovered;

  CovidInfo({
    this.countryName,
    this.cases,
    this.todayCases,
    this.deaths,
    this.todayDeaths,
    this.recovered,
    this.todayRecovered,
  });

  factory CovidInfo.fromJSON(Map<String, dynamic> covidData) {
    return CovidInfo(
      countryName: covidData['country'],
      cases: covidData['cases'],
      todayCases: covidData['todayCases'],
      deaths: covidData['deaths'],
      todayDeaths: covidData['todayDeaths'],
      recovered: covidData['recovered'],
      todayRecovered: covidData['todayRecovered'],
    );
  }
}
