import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guia_do_boleiro/core/constants/assets.dart';
import 'package:guia_do_boleiro/core/constants/colors.dart';
import 'package:guia_do_boleiro/core/constants/texts.dart';
import 'package:guia_do_boleiro/features/league/domain/controller/league_controller.dart';
import 'package:guia_do_boleiro/features/league/presentation/widgets/fixture_section.dart';
import 'package:guia_do_boleiro/features/league/presentation/widgets/rounds_dropdown.dart';
import 'package:guia_do_boleiro/shared/model/fixture.dart';
import 'package:guia_do_boleiro/shared/model/league.dart';
import 'package:guia_do_boleiro/shared/widgets/loading_ball.dart';

class LeaguePage extends StatelessWidget {
  League league;

  @override
  Widget build(BuildContext context) {
    league = Get.arguments as League;
    return GetBuilder<LeagueController>(
      initState: (_) {
        LeagueController.to.fetchLeagueRounds(league.leagueId);
        LeagueController.to.fetchNextFixtures(league.leagueId);
        LeagueController.to.fetchCurrentRoundFixtures(league.leagueId);
      },
      builder: (c) => Scaffold(
        backgroundColor: primaryColor,
        body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: LeagueHeader(),
                ),
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          NextFixturesSection(leaguePageNextFixturesSectionTitle,
                              c.nextFixtures, c.isLoadingNextFixtures.value),
                          NextFixturesSection(leaguePageRoundFixturesSectionTitle,
                              c.roundFixtures, c.isLoadingCurrentRoundFixtures.value),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget NextFixturesSection(
      String sectionTitle, List<Fixture> fixtures, bool isLoading) {
    return FixtureSection(
      isLoading: isLoading,
      fixtures: fixtures,
      sectionTitle: sectionTitle,
      showSeeMoreButton: true,
      seeMoreButtonFunction: () => null,
      seeMoreButtonText: countryLeaguesPageNextFixturesMoreButton,
    );
  }

  Widget LeagueHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: Hero(
              tag: league.logo,
              child: Image.network(league.logo),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Expanded(
            flex: 1,
            child: Text(
              league.name,
              style: GoogleFonts.firaSans(
                  textStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  child: SvgPicture.network(
                    league.flag,
                    height: 20,
                    width: 20,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  league.country,
                  style: GoogleFonts.firaSans(
                      textStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Expanded(
            flex: 4,
            child: SearchRound(),
          )
        ],
      ),
    );
  }

  Widget SearchRound() {
    return Column(
      children: [
        Text(
          leaguePageSearchForStatisticsWithAnyRound,
          style: GoogleFonts.firaSans(
              textStyle: TextStyle(color: secondaryColor, fontSize: 16)),
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: RoundsDropdown()),
            RawMaterialButton(
              onPressed: () => null,
              fillColor: secondaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              child: Text(
                leaguePageSearchContinue,
                style: GoogleFonts.firaSans(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            )
          ],
        )
      ],
    );
  }

  Widget LeagueLoading() {
    return Center(
      child: LoadingBall(
        size: 60,
      ),
    );
  }
}
