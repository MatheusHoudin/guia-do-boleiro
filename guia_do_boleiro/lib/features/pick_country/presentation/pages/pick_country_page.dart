import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guia_do_boleiro/core/constants/assets.dart';
import 'package:guia_do_boleiro/core/constants/colors.dart';
import 'package:guia_do_boleiro/core/constants/texts.dart';
import 'package:guia_do_boleiro/features/pick_country/domain/controller/get_countries_controller.dart';
import 'package:guia_do_boleiro/shared/model/country.dart';

class PickCountryPage extends StatelessWidget {
  final currentValue = 'Season 1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: AppIconAndName(),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                selectCountryInstructions,
                textAlign: TextAlign.center,
                style: GoogleFonts.firaSans(
                  color: secondaryColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w900
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 7,
                  child: CountriesScrollableView(),
                ),
                Expanded(
                  flex: 3,
                  child: SeasonSelectDropdown(),
                )
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 40
              ),
              child: RawMaterialButton(
                fillColor: secondaryColor,
                child: Text('Avançar'),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget AppIconAndName() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 30, bottom: 10),
          child: Image.asset(
            appIcon,
            scale: 2.5,
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              appName,
              style: GoogleFonts.firaSans(
                  fontSize: 30, color: textColor, fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }

  Widget CountryItem(Country country) {
    return Padding(
      padding: EdgeInsets.only(
        right: 20
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Container(
              decoration: BoxDecoration(

                border: Border.all(color: Colors.white, width: 2),
                shape: BoxShape.rectangle
              ),
              child: ClipRRect(
                child: SvgPicture.network(
                  country.flagUrl,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                country.country,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.firaSans(
                  color: Colors.white,
                  fontSize: 18
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget CountriesScrollableView() {
    return GetBuilder<GetCountriesController>(
      initState: (_) => GetCountriesController.to.fetchCountries(),
      builder: (c) => ListView.builder(
        itemExtent: Get.width * 0.4,
        padding: EdgeInsets.symmetric(horizontal: 10),
        scrollDirection: Axis.horizontal,
        itemCount: c.countries.length,
        itemBuilder: (context, index) {
          return CountryItem(c.countries[index]);
        },
      ),
    );
  }

  Widget SeasonSelectDropdown() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 50
      ),
      child: DropdownButton<String>(
        value: currentValue,
        onChanged: (value) {

        },
        isExpanded: true,
        icon: Icon(Icons.keyboard_arrow_down),
        iconSize: 24,
        elevation: 16,
        underline: Container(
          height: 2,
          color: secondaryColor,
        ),
        style: TextStyle(color: Colors.white),
        items: <String>['Season 1', 'Season 2', 'Season 3']
            .map((value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(color: secondaryColor),),
                ))
            .toList(),
      ),
    );
  }
}
