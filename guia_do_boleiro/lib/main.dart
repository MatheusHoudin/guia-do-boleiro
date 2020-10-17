import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guia_do_boleiro/core/constants/routes.dart';
import 'package:guia_do_boleiro/core/constants/texts.dart';
import 'package:guia_do_boleiro/core/di/country_leagues_page_bindings.dart';
import 'package:guia_do_boleiro/core/di/main_page_bindings.dart';
import 'package:guia_do_boleiro/core/di/pick_country_page_bindings.dart';
import 'package:guia_do_boleiro/features/countryleagues/presentation/pages/country_leagues_page.dart';
import 'package:guia_do_boleiro/features/pick_country/presentation/pages/pick_country_page.dart';

void main() {
  runApp(GetMaterialApp(
    title: appName,
    initialBinding: MainPageBindings(),
    initialRoute: pickCountryPageRoute,
    getPages: [
      GetPage(
        name: pickCountryPageRoute,
        page: () => PickCountryPage(),
        binding: PickCountryPageBindings()
      ),
      GetPage(
        name: countryLeaguesBySeason,
        page: () => CountryLeaguesPage(),
        binding: CountryLeaguesPageBindings()
      )
    ],
  ));
}
