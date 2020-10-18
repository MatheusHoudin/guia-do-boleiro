import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guia_do_boleiro/core/constants/colors.dart';

class CustomSearch extends StatelessWidget {
  final TextEditingController controller;
  final Function onChanged;
  final String hint;

  CustomSearch({this.controller, this.onChanged, this.hint});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: secondaryColor,
      style: FilterLeaguesTextStyle(Colors.white),
      onChanged: (filter) => onChanged(filter),
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: Colors.white, width: 2)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: secondaryColor, width: 2)),
          hintText: hint,
          hintStyle: FilterLeaguesTextStyle(Colors.white70)),
    );
  }

  TextStyle FilterLeaguesTextStyle(Color color) {
    return GoogleFonts.firaSans(
        color: color, fontSize: 16, fontWeight: FontWeight.bold);
  }
}
