import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guia_do_boleiro/core/constants/assets.dart';
import 'package:guia_do_boleiro/core/constants/routes.dart';
import 'package:guia_do_boleiro/core/constants/texts.dart';
import 'package:guia_do_boleiro/core/error/failure/failure.dart';
import 'package:guia_do_boleiro/core/ui/one_button_dialog.dart';
import 'package:guia_do_boleiro/features/pick_country/domain/usecase/get_countries_list_use_case.dart';
import 'package:guia_do_boleiro/shared/model/country.dart';
import 'package:guia_do_boleiro/shared/model/country_with_season.dart';

class GetCountriesController extends GetxController {
  final GetCountriesListUseCase getCountriesListUseCase;

  final TextEditingController countriesFilterController =
      TextEditingController();

  var countriesDispaly = <CountryWithPadding>[].obs;
  var countriesDispalyFiltered = <CountryWithPadding>[].obs;
  var isLoadingCountries = true.obs;
  var lastSelectedIndex = 0;
  final defaultPadding = 30.0;
  final growingContentPadding = 10.0;

  GetCountriesController({this.getCountriesListUseCase});

  static GetCountriesController get to => Get.find();

  void fetchCountries() async {
    var result = await getCountriesListUseCase(GetCountriesParams());

    result.fold((failure) {
      if (failure is ServerFailure) {
        Get.dialog(OneButtonDialog(
          title: failure.title,
          message: failure.message,
          image: sadIcon,
        ));
      } else {
        Get.dialog(OneButtonDialog(
          title: noInternetConnectionTitle,
          message: noInternetConnectionMessage,
          image: noInternetIcon,
        ));
      }
    }, (countriesResult) {
      isLoadingCountries.value = false;
      var countries = countriesResult
          .asMap()
          .map((index, country) => MapEntry(
              index,
              CountryWithPadding(
                  country: country,
                  padding:
                      index == 0 ? growingContentPadding : defaultPadding)))
          .values
          .toList();
      countriesDispaly.value = countries;
      countriesDispalyFiltered.value = countries;
      update();
    });
  }

  void onSelectCountry(int index) {
    countriesDispalyFiltered[lastSelectedIndex].padding = defaultPadding;
    countriesDispalyFiltered[index].padding = growingContentPadding;
    lastSelectedIndex = index;
    update();
  }

  void continueToCountryLeaguesPage(String season) {
    if (season.isEmpty) {
      Get.defaultDialog(
        title: pickCountryNotSelectedSeasonDialogTitle,
        content: Text(pickCountryNotSelectedSeasonDialogBody),
      );
    } else {
      var selectedCountry = _getSelectedCountry();

      if (selectedCountry != null) {
        Get.toNamed(countryLeaguesPageRoute,
            arguments:
                CountryWithSeason(country: selectedCountry, season: season));
      } else {
        Get.defaultDialog(
          title: pickCountryNotSelectedCountryDialogTitle,
          content: Text(pickCountryNotSelectedCountryDialogBody),
        );
      }
    }
  }

  void filterCountries(String filter) {
    countriesDispalyFiltered[lastSelectedIndex].padding = defaultPadding;
    if (filter.isEmpty) {
      countriesDispalyFiltered.value = countriesDispaly;
    } else {
      countriesDispalyFiltered.value = countriesDispaly
          .where((c) =>
          c.country.country.toUpperCase().contains(filter.toUpperCase()))
          .toList();
    }
    countriesDispalyFiltered[0].padding = growingContentPadding;
    lastSelectedIndex = 0;
    update();
  }

  Country _getSelectedCountry() => countriesDispalyFiltered.length > 0
      ? countriesDispalyFiltered[lastSelectedIndex].country
      : null;

  void dispose() {
    countriesFilterController.dispose();
  }
}

class CountryWithPadding {
  final Country country;
  double padding;

  CountryWithPadding({this.country, this.padding});
}
