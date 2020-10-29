import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guia_do_boleiro/core/constants/colors.dart';
import 'package:guia_do_boleiro/shared/model/league_tab.dart';

class ViewPagerTabItem extends StatelessWidget {
  final LeagueTab leagueTab;
  final bool isSelected;
  final int leagueId;

  ViewPagerTabItem({this.leagueTab,this.leagueId, this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => leagueTab.onClick(leagueId),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: isSelected ? secondaryColor : Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          child: Text(
            leagueTab.text,
            style: GoogleFonts.firaSans(
              fontSize: 16,
              color: isSelected ? Colors.white : primaryColor
            ),
          ),
        ),
      ),
    );
  }
}

