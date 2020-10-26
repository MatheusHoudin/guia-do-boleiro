import 'package:get/get.dart';
import 'package:guia_do_boleiro/core/constants/assets.dart';
import 'package:guia_do_boleiro/core/constants/texts.dart';
import 'package:guia_do_boleiro/core/error/failure/failure.dart';
import 'package:guia_do_boleiro/core/ui/one_button_dialog.dart';
import 'package:guia_do_boleiro/features/league/domain/usecase/get_league_rounds_use_case.dart';
import 'package:guia_do_boleiro/features/league/domain/usecase/get_live_fixtures_from_league_use_case.dart';
import 'package:guia_do_boleiro/features/league/domain/usecase/get_round_fixtures_use_case.dart';
import 'package:guia_do_boleiro/features/league/domain/usecase/get_today_fixtures_use_case.dart';
import 'package:guia_do_boleiro/shared/model/fixture.dart';

class LeagueController extends GetxController {
  final GetLiveFixturesFromLeagueUseCase getLiveFixturesFromLeagueUseCase;
  final GetTodayFixturesUseCase getTodayFixturesUseCase;
  final GetRoundFixturesUseCase getRoundFixturesUseCase;
  final GetLeagueRoundsUseCase getLeagueRoundsUseCase;

  var isLoadingLiveFixtures = false.obs;
  var isLoadingTodayFixtures = false.obs;
  var isLoadingRoundFixtures = false.obs;
  var isLoadingLeagueRoundsFixtures = false.obs;

  var _selectedLeagueRound = "".obs;

  var liveFixtures = <Fixture>[].obs;
  var roundFixtures = <Fixture>[].obs;
  var todayFixtures = <Fixture>[].obs;
  var leagueRounds = <String>[].obs;

  LeagueController(
      {this.getRoundFixturesUseCase,
      this.getTodayFixturesUseCase,
      this.getLiveFixturesFromLeagueUseCase,
      this.getLeagueRoundsUseCase});

  String get selectedRound => _selectedLeagueRound.value;

  static LeagueController get to => Get.find();

  void fetchLeagueRounds(int leagueId) async {
    isLoadingLeagueRoundsFixtures.value = true;

    var leagueRoundsOrFailure = await getLeagueRoundsUseCase(GetLeagueRoundsParams(leagueId: leagueId));

    leagueRoundsOrFailure.fold(
      (failure) {
        isLoadingLeagueRoundsFixtures.value = false;

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
      },
      (rounds) {
        isLoadingLeagueRoundsFixtures.value = false;
        _selectedLeagueRound.value = rounds.first;
        leagueRounds.value = rounds;
        update();
      }
    );
  }

  void onChangeLeagueRound(String selectedRound) {
    _selectedLeagueRound.value = selectedRound;
    update();
  }

  void fetchLiveFixtures(int leagueId) async {
    isLoadingLiveFixtures.value = true;

    var liveFixturesOrFailure = await getLiveFixturesFromLeagueUseCase(
        GetLiveFixturesFromLeagueParams(leagueId: leagueId));

    liveFixturesOrFailure.fold((failure) {
      isLoadingLiveFixtures.value = false;
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
    }, (fixtures) {
      isLoadingLiveFixtures.value = false;
      liveFixtures.value = fixtures;
      update();
    });
  }

  void fetchRoundFixtures(String round, int leagueId) async {
    isLoadingRoundFixtures.value = true;

    var roundFixturesOrFailure = await getRoundFixturesUseCase(
        RoundFixturesParams(round: round, league: leagueId));

    roundFixturesOrFailure.fold((failure) {
      isLoadingRoundFixtures.value = false;
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
    }, (fixtures) {
      isLoadingRoundFixtures.value = false;
      roundFixtures.value = fixtures;
      update();
    });
  }

  void fetchTodayFixtures(int leagueId) async {
    isLoadingTodayFixtures.value = true;

    var todayFixturesOrFailure = await getTodayFixturesUseCase(
        GetTodayFixturesParams(leagueId: leagueId));

    todayFixturesOrFailure.fold((failure) {
      isLoadingTodayFixtures.value = false;
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
    }, (fixtures) {
      isLoadingTodayFixtures.value = false;
      todayFixtures.value = fixtures;
      update();
    });
  }
}
