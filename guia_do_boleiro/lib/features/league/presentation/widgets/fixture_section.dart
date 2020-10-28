import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guia_do_boleiro/core/constants/colors.dart';
import 'package:guia_do_boleiro/features/league/presentation/widgets/fixture_item.dart';
import 'package:guia_do_boleiro/shared/model/fixture.dart';
import 'package:guia_do_boleiro/shared/widgets/loading_ball.dart';

class FixtureSection extends StatelessWidget {
  final String sectionTitle;
  final String seeMoreButtonText;
  final List<Fixture> fixtures;
  final bool isLoading;
  final bool showSeeMoreButton;
  final Function seeMoreButtonFunction;

  FixtureSection(
      {this.sectionTitle,
      this.isLoading,
      this.fixtures,
      this.seeMoreButtonFunction,
      this.seeMoreButtonText,
      this.showSeeMoreButton});

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? LeagueLoading()
        : Container(
            height: Get.height * 0.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      sectionTitle,
                      style: GoogleFonts.firaSans(
                          textStyle: TextStyle(
                              color: secondaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                    ),
                    RawMaterialButton(
                      onPressed: () => null,
                      fillColor: secondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      child: Text(
                        seeMoreButtonText,
                        style: GoogleFonts.firaSans(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: fixtures.length,
                    itemBuilder: (context, index) =>
                        FixtureItem(fixture: fixtures[index],),
                  ),
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
}
