String formatToBrazilianDate(String date) {
  final splits = date.split('-');
  return "${splits[2]}/${splits[1]}/${splits[0]}";
}
