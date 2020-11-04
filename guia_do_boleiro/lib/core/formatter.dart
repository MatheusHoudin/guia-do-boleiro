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
  if (round.contains(' - ')) {
    return 'Round ${round.split(' - ')[1]}';
  } else if (round.contains('st ')) {
    return 'Round ${round.split('st ')[0]}';
  } else if (round.contains('nd ')) {
    return 'Round ${round.split('nd ')[0]}';
  } else if (round.contains('rd ')) {
    return 'Round ${round.split('rd ')[0]}';
  } else if (round.contains('th ')) {
    return 'Round ${round.split('th ')[0]}';
  } else {
    return 'Round ???';
  }
}

String formatRound(String round) {
  if (round.contains('_-_')) {
    return 'Round ${round.split('_-_')[1]}';
  } else if (round.contains('st_')) {
    return 'Round ${round.split('st_')[0]}';
  } else if (round.contains('nd_')) {
    return 'Round ${round.split('nd_')[0]}';
  } else if (round.contains('rd_')) {
    return 'Round ${round.split('rd_')[0]}';
  } else if (round.contains('th_')) {
    return 'Round ${round.split('th_')[0]}';
  } else {
    return 'Round ???';
  }
}
