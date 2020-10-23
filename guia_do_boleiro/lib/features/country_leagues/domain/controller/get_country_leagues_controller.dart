import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:guia_do_boleiro/core/constants/assets.dart';
import 'package:guia_do_boleiro/core/constants/routes.dart';
import 'package:guia_do_boleiro/core/constants/texts.dart';
import 'package:guia_do_boleiro/core/error/failure/failure.dart';
import 'package:guia_do_boleiro/core/ui/one_button_dialog.dart';
import 'package:guia_do_boleiro/features/country_leagues/domain/usecase/get_country_leagues_use_case.dart';
import 'package:guia_do_boleiro/shared/model/league.dart';

class GetCountryLeaguesController extends GetxController {
  final GetCountryLeaguesUseCase useCase;
  var leagues = <League>[].obs;
  var leaguesFiltered = <League>[].obs;
  var isLoadingLeagues = true.obs;
  final TextEditingController leagueFilterController = TextEditingController();

  GetCountryLeaguesController({this.useCase});

  static GetCountryLeaguesController get to => Get.find();

  void fetchLeagues(String country, String season) async {
    final leaguesOrFailure =
        await useCase(CountryAndSeasonParams(country: country, season: season));

    leaguesOrFailure.fold((failure) {
      isLoadingLeagues.value = false;
      if (failure is ServerFailure) {
        Get.dialog(OneButtonDialog(
          title: failure.title,
          message: failure.message,
          image: sadIcon,
        ));
      } else if (failure is NoInternetConnectionFailure) {
        Get.dialog(OneButtonDialog(
          title: noInternetConnectionTitle,
          message: noInternetConnectionMessage,
          image: sadIcon,
        ));
      }
    }, (leaguesResponse) {
      isLoadingLeagues.value = false;
      leaguesFiltered.value = leaguesResponse;
      leagues.value = leaguesResponse;
      update();
    });
  }

  void filterLeagues(String filter) {
    print(filter);
    if (filter == "") {
      leaguesFiltered.value = leagues;
    } else {
      leaguesFiltered.value = leagues
          .where((league) =>
              league.name.toUpperCase().contains(filter.toUpperCase()))
          .toList();
    }
    print(leaguesFiltered);
    update();
  }

  void continueToLeaguePage(League selectedLeague) {
    Get.toNamed(leaguePageRoute, arguments: selectedLeague);
  }

  void dispose() {
    leagueFilterController.dispose();
  }
}
