import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guia_do_boleiro/core/constants/assets.dart';
import 'package:guia_do_boleiro/core/constants/texts.dart';
import 'package:guia_do_boleiro/core/error/failure/failure.dart';
import 'package:guia_do_boleiro/core/ui/one_button_dialog.dart';
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
        if (failure is ServerFailure) {
          Get.dialog(OneButtonDialog(
            title: failure.title,
            message: failure.message,
            image: sadIcon,
          ));
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
