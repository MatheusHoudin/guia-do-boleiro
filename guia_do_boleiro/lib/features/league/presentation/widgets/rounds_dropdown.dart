import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guia_do_boleiro/core/constants/colors.dart';
import 'package:guia_do_boleiro/features/league/domain/controller/league_controller.dart';
import 'package:guia_do_boleiro/shared/widgets/loading_ball.dart';

class RoundsDropdown extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LeagueController>(
      builder: (c) => c.isLoadingLeagueRoundsFixtures.value
          ? SeasonsLoading()
          : Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(10)),
        child: DropdownButton<String>(
          value: c.selectedRound,
          isDense: true,
          onChanged: (value) {
            c.onChangeLeagueRound(value);
          },
          isExpanded: true,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: secondaryColor,
          ),
          iconSize: 24,
          elevation: 16,
          underline: Container(
            height: 0,
          ),
          items: c.leagueRounds
              .map((value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value,
                textAlign: TextAlign.center,
                style: GoogleFonts.firaSans(
                    textStyle: TextStyle(
                        color: secondaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20))),
          ))
              .toList(),
        ),
      ),
    );
  }

  Widget SeasonsLoading() {
    return Center(
      child: LoadingBall(size: 40,),
    );
  }
}
