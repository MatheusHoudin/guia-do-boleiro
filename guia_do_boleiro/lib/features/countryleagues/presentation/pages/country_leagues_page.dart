import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guia_do_boleiro/shared/model/country_with_season.dart';

class CountryLeaguesPage extends StatelessWidget {
  CountryWithSeason countryWithSeason;

  @override
  Widget build(BuildContext context) {
    countryWithSeason = Get.arguments as CountryWithSeason;
    return Scaffold(
      body: Text(countryWithSeason.season),
    );
  }
}
