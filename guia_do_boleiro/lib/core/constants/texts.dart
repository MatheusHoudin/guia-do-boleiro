const appName = 'Soccer World';

//dialog
const ok = "OK";
//dialog

//failures
const noInternetConnectionTitle = "Ops...";
const noInternetConnectionMessage = "You may have a connection issue, would you mind checking it?";
//failures

//pick_country_page
const pickCountryPageInstructions = 'Pick up a country and season to get full details on matches, teams, statistics and more';
const pickCountryPageContinueButton = 'Continue';
const pickCountryNotSelectedSeasonDialogTitle = "Ops...";
const pickCountryNotSelectedSeasonDialogBody = "You must select a season";
const pickCountryNotSelectedCountryDialogTitle = "Ops...";
const pickCountryNotSelectedCountryDialogBody = "You must select a country";
const pickCountryCountriesFilterHint = 'Search your desired country';
//pick_country_page

//country_leagues_page
const countryLeaguesPageInfo = 'Select one of the leagues below to get full details on matches, teams, statistics and more';
const countryLeaguesPageFilterLeagueHint = 'Which league are you looking for?';
const countryLeaguesPageThereAreNoLeagues = 'There are no leagues with the country and season selected, what about trying out another season?';
var countryLeaguesPageFromToFunction = (start, end) => "From $start to $end";
//country_leagues_page

// get_country_repository
const getCountryRepositoryServerFailureTitle = 'Unfortunately an error ocurred';
const getCountryRepositoryServerFailureMessage = 'We could not fetch countries, please try again';
// get_country_repository

// get_seasons_repository
const getSeasonsRepositoryServerFailureTitle = 'Unfortunately an error ocurred';
const getSeasonsRepositoryServerFailureMessage = 'We could not fetch seasons, please try again';
// get_seasons_repository

// get_country_seasons_repository
const getCountrySeasonsRepositoryServerFailureTitle = 'Unfortunately an error ocurred';
const getCountrySeasonsRepositoryServerFailureMessage = 'We could not fetch leagues from the selected country and season, please try again';
// get_country_seasons_repository

// get_live_fixtures_from_league_repository
const getLiveFixturesFromLeagueRepositoryServerFailureTitle = 'Unfortunately an error ocurred';
const getLiveFixturesFromLeagueRepositoryServerFailureMessage = 'We could not fetch fixtures, please try again';
// get_live_fixtures_from_league_repository
