import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guia_do_boleiro/core/error/failure/failure.dart';
import 'package:guia_do_boleiro/features/get_seasons/domain/usecase/get_seasons_use_case.dart';

class GetSeasonsController extends GetxController {
  final GetSeasonsUseCase useCase;
  var seasons = <String>[].obs;
  var _selectedSeason = "".obs;
  var isLoadingSeasons = true.obs;

  GetSeasonsController({this.useCase});

  static GetSeasonsController get to => Get.find();

  String get season => _selectedSeason.value;

  void fetchSeasons() async {
    final response = await useCase(GetSeasonsParams());

    response.fold(
      (failure) {
        if(failure is ServerFailure) {
          Get.defaultDialog(
              title: failure.title,
              content: Text(failure.message)
          );
        }
      },
      (seasonsResult) {
        isLoadingSeasons.value = false;
        seasons.value = seasonsResult;
        _selectedSeason.value = seasonsResult.first;
        update();
      }
    );
  }

  void changeSelectedSeason(String season) {
    _selectedSeason.value = season;
    update();
  }
}
