class CovidInfoCountry {
  final String countryName;
  final String flag;
  final int cases;
  final int todayCases;
  final int deaths;
  final int todayDeaths;
  final int recovered;
  final int todayRecovered;

  CovidInfoCountry({
    this.countryName,
    this.flag,
    this.cases,
    this.todayCases,
    this.deaths,
    this.todayDeaths,
    this.recovered,
    this.todayRecovered,
  });

  factory CovidInfoCountry.fromJSON(Map<String, dynamic> covidData) {
    return CovidInfoCountry(
      countryName: covidData['country'],
      flag: covidData['countryInfo']['flag'],
      cases: covidData['cases'],
      todayCases: covidData['todayCases'],
      deaths: covidData['deaths'],
      todayDeaths: covidData['todayDeaths'],
      recovered: covidData['recovered'],
      todayRecovered: covidData['todayRecovered'],
    );
  }
}
