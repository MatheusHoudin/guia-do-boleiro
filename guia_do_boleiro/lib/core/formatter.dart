String formatToBrazilianDate(String date) {
  print(date);
  final splits = date.split('-');
  return "${splits[2]}/${splits[1]}/${splits[0]}";
}
