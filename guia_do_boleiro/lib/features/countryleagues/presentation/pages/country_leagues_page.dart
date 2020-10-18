import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guia_do_boleiro/core/constants/assets.dart';
import 'package:guia_do_boleiro/core/constants/colors.dart';
import 'package:guia_do_boleiro/core/constants/texts.dart';
import 'package:guia_do_boleiro/features/countryleagues/domain/controller/get_country_leagues_controller.dart';
import 'package:guia_do_boleiro/shared/model/country_with_season.dart';
import 'package:guia_do_boleiro/shared/model/league.dart';
import 'package:guia_do_boleiro/shared/widgets/custom_search.dart';
import 'package:guia_do_boleiro/shared/widgets/loading_ball.dart';

class CountryLeaguesPage extends StatelessWidget {
  CountryWithSeason countryWithSeason;

  @override
  Widget build(BuildContext context) {
    countryWithSeason = Get.arguments as CountryWithSeason;
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColor,
        body: GetBuilder<GetCountryLeaguesController>(
          initState: (_) => GetCountryLeaguesController.to.fetchLeagues(
              countryWithSeason.country.country, countryWithSeason.season),
          dispose: (_) => GetCountryLeaguesController.to.dispose(),
          builder: (c) => Body(),
        ),
      ),
    );
  }

  Widget Body() {
    return SingleChildScrollView(
      child: Container(
        height: Get.height,
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 7,
              child: Stack(
                children: [
                  Opacity(
                    opacity: 0.25,
                    child: SvgPicture.network(
                      countryWithSeason.country.flagUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Header()
                ],
              ),
            ),
            Divider(
              height: 4,
              color: secondaryColor,
            ),
            Expanded(
                flex: 13,
                child: GetCountryLeaguesController.to.isLoadingLeagues.value
                    ? CountryLeaguesLoading()
                    : (GetCountryLeaguesController.to.leagues.length == 0
                        ? ThereAreNoLeagues()
                        : Leagues()))
          ],
        ),
      ),
    );
  }

  Widget ThereAreNoLeagues() {
    return Center(
      child: Container(
        width: Get.width * 0.8,
        height: Get.height * 0.4,
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: SvgPicture.asset(noLeaguesIcon),
            ),
            SizedBox(height: 20,),
            Expanded(
              flex: 4,
              child: Text(
                countryLeaguesPageThereAreNoLeagues,
                textAlign: TextAlign.justify,
                style: GoogleFonts.firaSans(
                  fontSize: 22,
                  color: secondaryColor,
                  fontWeight: FontWeight.bold
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget CountryLeaguesLoading() {
    return Center(
      child: LoadingBall(
        size: 60,
      ),
    );
  }

  Widget Header() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            CountryDataHeaderSection(),
            CountryDataHeaderInstructions(),
            LeaguesFilterEditText()
          ],
        ),
      ),
    );
  }

  Widget CountryDataHeaderSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Hero(
          tag: countryWithSeason.country.country,
          child: Card(
            margin: EdgeInsets.only(right: 20),
            shape:
                RoundedRectangleBorder(side: BorderSide(color: Colors.white)),
            child: SvgPicture.network(
              countryWithSeason.country.flagUrl,
              fit: BoxFit.cover,
              width: 60,
              height: 60,
              placeholderBuilder: (_) => LoadingBall(
                size: 40,
              ),
            ),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                countryWithSeason.country.country,
                style: GoogleFonts.firaSans(color: Colors.white, fontSize: 22),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                countryWithSeason.season,
                style:
                    GoogleFonts.firaSans(color: secondaryColor, fontSize: 18),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget CountryDataHeaderInstructions() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Text(
        countryLeaguesPageInfo,
        textAlign: TextAlign.center,
        style: GoogleFonts.firaSans(
            color: secondaryColor, fontSize: 20, fontWeight: FontWeight.w900),
      ),
    );
  }

  Widget LeaguesFilterEditText() {
    return CustomSearch(
      controller: GetCountryLeaguesController.to.leagueFilterController,
      onChanged: (filter) => GetCountryLeaguesController.to.filterLeagues(filter),
      hint: countryLeaguesPageFilterLeagueHint,
    );
  }

  Widget Leagues() {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Wrap(
          runSpacing: 10,
          alignment: WrapAlignment.spaceEvenly,
          children: GetCountryLeaguesController.to.leaguesFiltered
              .map((league) => LeagueItem(league))
              .toList(),
        ),
      ),
    );
  }

  Widget LeagueItem(League league) {
    return Container(
      width: Get.width,
      height: Get.width * 0.3,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(6),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Image.network(league.logo),
              ),
              SizedBox(
                width: 10,
              ),
              VerticalDivider(
                width: 1,
                color: primaryColor,
                thickness: 2,
                indent: 20,
                endIndent: 20,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      league.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.firaSans(
                          color: primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      league.type,
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.firaSans(
                          color: primaryColor, fontSize: 18),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Visibility(
                      visible: (league.seasonStart != null && league.seasonStart != null),
                      child: Text(
                        "De ${league.seasonStart} até ${league.seasonEnd}",
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.firaSans(
                            color: secondaryColor, fontSize: 14),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
