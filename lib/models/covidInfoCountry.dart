class CovidInfoCountry {
  final String? countryName;
  final String? flag;
  final String? continent;
  final int? population;
  final int? cases;
  final int? todayCases;
  final int? deaths;
  final int? todayDeaths;
  final int? recovered;
  final int? todayRecovered;
  final int? active;
  final int? critical;
  final dynamic casesPerOneMillion;
  final dynamic deathsPerOneMillion;
  final int? tests;
  final dynamic testsPerOneMillion;
  final int? oneCasePerPeople;
  final int? oneDeathPerPeople;
  final int? oneTestPerPeople;
  final dynamic activePerOneMillion;
  final dynamic recoveredPerOneMillion;
  final dynamic criticalPerOneMillion;

  CovidInfoCountry({
    this.countryName,
    this.flag,
    this.continent,
    this.population,
    this.cases,
    this.todayCases,
    this.deaths,
    this.todayDeaths,
    this.recovered,
    this.todayRecovered,
    this.active,
    this.critical,
    this.casesPerOneMillion,
    this.deathsPerOneMillion,
    this.tests,
    this.testsPerOneMillion,
    this.oneCasePerPeople,
    this.oneDeathPerPeople,
    this.oneTestPerPeople,
    this.activePerOneMillion,
    this.recoveredPerOneMillion,
    this.criticalPerOneMillion,
  });

  factory CovidInfoCountry.fromJSON(Map<String, dynamic> covidData) {
    return CovidInfoCountry(
      countryName: covidData['country'],
      flag: covidData['countryInfo']['flag'],
      continent: covidData['continent'],
      population: covidData['population'],
      cases: covidData['cases'],
      todayCases: covidData['todayCases'],
      deaths: covidData['deaths'],
      todayDeaths: covidData['todayDeaths'],
      recovered: covidData['recovered'],
      todayRecovered: covidData['todayRecovered'],
      active: covidData['active'],
      critical: covidData['critical'],
      casesPerOneMillion: covidData['casesPerOneMillion'],
      deathsPerOneMillion: covidData['deathsPerOneMillion'],
      tests: covidData['tests'],
      testsPerOneMillion: covidData['testsPerOneMillion'],
      oneCasePerPeople: covidData['oneCasePerPeople'],
      oneDeathPerPeople: covidData['oneDeathPerPeople'],
      oneTestPerPeople: covidData['oneTestPerPeople'],
      activePerOneMillion: covidData['activePerOneMillion'],
      recoveredPerOneMillion: covidData['recoveredPerOneMillion'],
      criticalPerOneMillion: covidData['criticalPerOneMillion'],
    );
  }
}
