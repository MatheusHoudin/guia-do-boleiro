import 'package:get/get.dart';
import 'package:guia_do_boleiro/core/constants/assets.dart';
import 'package:guia_do_boleiro/core/error/failure/failure.dart';
import 'package:guia_do_boleiro/core/ui/one_button_dialog.dart';
import 'package:guia_do_boleiro/features/countryleagues/domain/usecase/get_country_leagues_use_case.dart';
import 'package:guia_do_boleiro/shared/model/league.dart';
import 'package:guia_do_boleiro/core/constants/texts.dart';

class GetCountryLeaguesController extends GetxController {
  final GetCountryLeaguesUseCase useCase;
  var leagues = <League>[].obs;
  var isLoadingLeagues = true.obs;

  GetCountryLeaguesController({this.useCase});

  static GetCountryLeaguesController get to => Get.find();

  void fetchLeagues(String country, String season) async {
    final leaguesOrFailure = await useCase(CountryAndSeasonParams(country: country, season: season));

    leaguesOrFailure.fold(
      (failure) {
        isLoadingLeagues.value = false;
        if (failure is ServerFailure) {
          Get.dialog(OneButtonDialog(
            title: failure.title,
            message: failure.message,
            image: sadIcon,
          ));
        }else if(failure is NoInternetConnectionFailure) {
          Get.dialog(OneButtonDialog(
            title: noInternetConnectionTitle,
            message: noInternetConnectionMessage,
            image: sadIcon,
          ));
        }
      },
      (leaguesResponse) {
        isLoadingLeagues.value = false;
        leagues.value = leaguesResponse;
        update();
      }
    );
  }
}
