import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guia_do_boleiro/features/pick_country/domain/usecase/get_countries_list_use_case.dart';
import 'package:guia_do_boleiro/shared/model/country.dart';

class GetCountriesController extends GetxController {
  final GetCountriesListUseCase getCountriesListUseCase;

  var countries = <Country>[].obs;

  GetCountriesController({this.getCountriesListUseCase});

  static GetCountriesController get to => Get.find();

  void fetchCountries() async{
    var result = await getCountriesListUseCase(GetCountriesParams());

    result.fold(
      (countriesResult) {
        Get.defaultDialog(
          title: "Erro",
          content: Text("Ocorreu um erro ao buscar os paises")
        );
      },
      (countriesResult) {
        countries.value = countriesResult;
        update();
      }
    );
  }
}
