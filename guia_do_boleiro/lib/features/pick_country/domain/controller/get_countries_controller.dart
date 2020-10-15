import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guia_do_boleiro/core/error/failure/failure.dart';
import 'package:guia_do_boleiro/features/pick_country/domain/usecase/get_countries_list_use_case.dart';
import 'package:guia_do_boleiro/shared/model/country.dart';

class GetCountriesController extends GetxController {
  final GetCountriesListUseCase getCountriesListUseCase;

  var countriesDispaly = <CountryWithPadding>[].obs;
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
        Get.defaultDialog(title: failure.title, content: Text(failure.message));
      }
    }, (countriesResult) {
      isLoadingCountries.value = false;
      countriesDispaly.value = countriesResult.asMap()
          .map((index, country) => MapEntry(
              index,
              CountryWithPadding(
                  country: country,
                  padding:
                      index == 0 ?
                      growingContentPadding
                          :
                      defaultPadding
              )))
          .values
          .toList();
      update();
    });
  }

  void onSelectCountry(int index) {
    countriesDispaly[lastSelectedIndex].padding = defaultPadding;
    countriesDispaly[index].padding = growingContentPadding;
    lastSelectedIndex = index;
    update();
  }

  Country getSelectedCountry() => countriesDispaly[lastSelectedIndex].country;
}

class CountryWithPadding {
  final Country country;
  double padding;

  CountryWithPadding({this.country, this.padding});
}
