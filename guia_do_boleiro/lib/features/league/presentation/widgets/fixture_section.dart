import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guia_do_boleiro/core/constants/assets.dart';
import 'package:guia_do_boleiro/core/constants/colors.dart';
import 'package:guia_do_boleiro/core/constants/texts.dart';
import 'package:guia_do_boleiro/features/league/presentation/widgets/fixture_item.dart';
import 'package:guia_do_boleiro/shared/model/fixture.dart';
import 'package:guia_do_boleiro/shared/widgets/loading_ball.dart';

class FixtureSection extends StatelessWidget {
  final String sectionTitle;
  final List<Fixture> fixtures;
  final bool isLoading;

  FixtureSection(
      {this.sectionTitle,
      this.isLoading,
      this.fixtures});

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? LeagueLoading()
        : Container(
            height: Get.height * 0.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                fixtures.length > 0 ? Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: fixtures.length,
                    itemBuilder: (context, index) =>
                        FixtureItem(fixture: fixtures[index],),
                  ),
                ) : Center(
                  child: ThereAreNoFixtures()
                ),
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

  Widget ThereAreNoFixtures() {
    return Center(
      child: Container(
        width: Get.width * 0.8,
        height: Get.height * 0.4,
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: SvgPicture.asset(noFixturesIcon),
            ),
            SizedBox(height: 20,),
            Expanded(
              flex: 4,
              child: Text(
                thereAreNoFixtures,
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
}
