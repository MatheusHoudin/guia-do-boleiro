import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guia_do_boleiro/core/constants/assets.dart';
import 'package:guia_do_boleiro/shared/model/fixture.dart';
import 'package:guia_do_boleiro/shared/widgets/loading_ball.dart';

class FixtureItem extends StatelessWidget {
  final Fixture fixture;

  FixtureItem({this.fixture});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          TeamImageAndName(fixture.homeTeam.logo, fixture.homeTeam.name),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                (fixture.status == 'Not Started')
                    ? Text(
                        '${fixture.eventDate} - ${fixture.round}',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.firaSans(
                            color: Colors.white, fontSize: 14),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            fixture.goalsHomeTeam.toString(),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.firaSans(
                                color: Colors.white, fontSize: 14),
                          ),
                          (fixture.status != 'Match Finished')
                              ? LoadingBall(
                                  size: 14,
                                )
                              : SvgPicture.asset(
                                  loadingBallIcon,
                                  width: 14,
                                  height: 14,
                                ),
                          Text(
                            fixture.goalsAwayTeam.toString(),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.firaSans(
                                color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      soccerFieldIcon,
                      height: 14,
                      width: 14,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: Text(
                        fixture.venue,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.firaSans(
                            color: Colors.grey, fontSize: 14),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: 8,
          ),
          TeamImageAndName(fixture.awayTeam.logo, fixture.awayTeam.name),
        ],
      ),
    );
  }

  Widget TeamImageAndName(String image, String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          child: Image.network(
            image,
            height: 60,
            width: 60,
          ),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          name,
          style: GoogleFonts.firaSans(
              textStyle: TextStyle(fontSize: 14, color: Colors.white)),
        )
      ],
    );
  }
}
