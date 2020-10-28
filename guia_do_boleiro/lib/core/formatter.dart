String formatToBrazilianDate(String date) {
  print(date);
  final splits = date.split('-');
  return "${splits[2]}/${splits[1]}/${splits[0]}";
}

String formatDateTime(String dateTime) {
  final splits = dateTime.split('+')[0].split('T');

  return '${splits[0]} at ${splits[1].substring(0, 5)}';
}

String formatFixtureRound(String round) {
  return 'Round ${round.toString().split(' - ')[1]}';
}
