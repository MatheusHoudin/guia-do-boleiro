import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guia_do_boleiro/core/constants/colors.dart';
import 'package:guia_do_boleiro/core/constants/texts.dart';
import 'package:guia_do_boleiro/features/league/domain/controller/league_controller.dart';
import 'package:guia_do_boleiro/features/league/presentation/widgets/fixture_section.dart';
import 'package:guia_do_boleiro/features/league/presentation/widgets/rounds_dropdown.dart';
import 'package:guia_do_boleiro/features/league/presentation/widgets/view_pager_tab_item.dart';
import 'package:guia_do_boleiro/shared/model/fixture.dart';
import 'package:guia_do_boleiro/shared/model/league.dart';
import 'package:guia_do_boleiro/shared/widgets/loading_ball.dart';

class LeaguePage extends StatelessWidget {
  League league;
  PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    if (Get.arguments != null ) league = Get.arguments as League;
    return GetBuilder<LeagueController>(
      initState: (_) {
        LeagueController.to.fetchLeagueRounds(league.leagueId);
        LeagueController.to.fetchNextFixtures(league.leagueId);
        LeagueController.to.fetchCurrentRoundFixtures(league.leagueId);
      },
      builder: (c) => Scaffold(
        backgroundColor: primaryColor,
        body: SafeArea(
            child: Container(
          height: Get.height,
          width: Get.width,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: LeagueHeader(),
              ),
              Expanded(
                flex: 7,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 40,
                        child: ListView.builder(
                          itemCount: c.tabs.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => ViewPagerTabItem(
                            leagueTab: c.tabs[index],
                            leagueId: league.leagueId,
                            isSelected: c.tabsItemSelected[index],
                          ),
                        ),
                      ),
                      Expanded(
                        child: PageView(
                          controller: controller,
                          onPageChanged: (index) => c.onChangeViewPager(index, league.leagueId),
                          children: [
                            CustomFixturesSection(
                                leaguePageTodayFixturesSectionTitle,
                                c.todayFixtures,
                                c.isLoadingTodayFixtures.value),
                            CustomFixturesSection(
                                leaguePageRoundFixturesSectionTitle,
                                c.roundFixtures,
                                c.isLoadingCurrentRoundFixtures.value),
                            CustomFixturesSection(
                                leaguePageNextFixturesSectionTitle,
                                c.nextFixtures,
                                c.isLoadingNextFixtures.value),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }

  Widget CustomFixturesSection(
      String sectionTitle, List<Fixture> fixtures, bool isLoading) {
    return FixtureSection(
      isLoading: isLoading,
      fixtures: fixtures,
      sectionTitle: sectionTitle
    );
  }

  Widget LeagueHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: Get.height * 0.2,
            width: Get.width * 0.2,
            child: Hero(
              tag: league.logo,
              child: Image.network(league.logo),
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                league.name,
                style: GoogleFonts.firaSans(
                    textStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ),
              Row(
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
                    textAlign: TextAlign.center,
                    style: GoogleFonts.firaSans(
                        textStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ],
          )
        ],
      ),
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
