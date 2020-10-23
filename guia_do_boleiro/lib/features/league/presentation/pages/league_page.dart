import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guia_do_boleiro/core/constants/colors.dart';
import 'package:guia_do_boleiro/shared/model/league.dart';

class LeaguePage extends StatelessWidget {
  League league;

  @override
  Widget build(BuildContext context) {
    league = Get.arguments as League;
    return Scaffold(
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
              child: Container(color: Colors.red,),
            )
          ],
        )
      ),
    );
  }
  
  Widget LeagueHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10
      ),
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: Hero(
              tag: league.logo,
              child: Image.network(league.logo),
            ),
          ),
          SizedBox(height: 8,),
          Expanded(
            flex: 2,
            child: Text(
              league.name,
              style: GoogleFonts.firaSans(
                textStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                )
              ),
            ),
          ),
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
                SizedBox(width: 10,),
                Text(
                  league.country,
                  style: GoogleFonts.firaSans(
                    textStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    )
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 16,),
          Expanded(
            flex: 4,
            child: Container(color: Colors.grey,),
          )
        ],
      ),
    );
  }
}
