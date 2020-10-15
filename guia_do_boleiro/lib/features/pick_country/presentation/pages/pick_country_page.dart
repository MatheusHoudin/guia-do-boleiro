import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guia_do_boleiro/core/constants/assets.dart';
import 'package:guia_do_boleiro/core/constants/colors.dart';
import 'package:guia_do_boleiro/core/constants/routes.dart';
import 'package:guia_do_boleiro/core/constants/texts.dart';
import 'package:guia_do_boleiro/features/get_seasons/domain/controller/get_seasons_controller.dart';
import 'package:guia_do_boleiro/features/get_seasons/presentation/widgets/seasons_dropdown.dart';
import 'package:guia_do_boleiro/features/pick_country/domain/controller/get_countries_controller.dart';
import 'package:guia_do_boleiro/shared/model/country.dart';
import 'package:guia_do_boleiro/shared/model/country_with_season.dart';
import 'package:shimmer/shimmer.dart';

class PickCountryPage extends StatelessWidget {
  final pageViewController = PageController(
    viewportFraction: 1 / 2,
  );

  @override
  Widget build(BuildContext context) {
    print((GetCountriesController.to.isLoadingCountries.value ||
        GetSeasonsController.to.isLoadingSeasons.value));
    return Scaffold(
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: Get.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: AppIconAndName(),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      pickCountryPageInstructions,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.firaSans(
                          color: secondaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 16,
                      child: CountriesScrollableView(),
                    ),
                    Expanded(
                      flex: 4,
                      child: SeasonsDropdown(),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                flex: 1,
                child: (GetCountriesController.to.isLoadingCountries.value ||
                        GetSeasonsController.to.isLoadingSeasons.value)
                    ? ContinueButtonLoading()
                    : ContinueButton(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget ContinueButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: RawMaterialButton(
        onPressed: () => Get.toNamed(countryLeaguesBySeason,
            arguments: CountryWithSeason(
                country: GetCountriesController.to.getSelectedCountry(),
                season: GetSeasonsController.to.season)),
        fillColor: secondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        child: Text(
          pickCountryPageContinueButton,
          style: GoogleFonts.firaSans(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }

  Widget ContinueButtonLoading() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Shimmer.fromColors(
        highlightColor: Colors.white,
        baseColor: Colors.grey[400],
        child: Container(
          height: 20,
          width: 30,
          decoration:
              BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                color: Colors.white,
              ),
        ),
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
                  fontSize: 28, color: textColor, fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }

  Widget CountryLoading(double itemPadding) {
    return Shimmer.fromColors(
      highlightColor: Colors.white,
      baseColor: Colors.grey[400],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 7,
            child: Container(
              padding: EdgeInsets.all(itemPadding),
              width: Get.width * 0.4,
              color: Colors.white,
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 14),
              width: Get.width * 0.28,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  Widget CountryItem(Country country, double itemPadding) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 7,
          child: AnimatedPadding(
            padding: EdgeInsets.all(itemPadding),
            duration: Duration(milliseconds: 500),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  shape: BoxShape.rectangle),
              child: ClipRRect(
                child: SvgPicture.network(
                  country.flagUrl,
                  fit: BoxFit.fill,
                  placeholderBuilder: (context) => Text('djskad'),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              country.country,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.firaSans(color: Colors.white, fontSize: 18),
            ),
          ),
        )
      ],
    );
  }

  Widget CountriesScrollableView() {
    return GetBuilder<GetCountriesController>(
      initState: (_) => GetCountriesController.to.fetchCountries(),
      builder: (c) => c.isLoadingCountries.value
          ? CountriesLoading()
          : PageView.builder(
              onPageChanged: (page) => c.onSelectCountry(page),
              controller: pageViewController,
              scrollDirection: Axis.horizontal,
              itemCount: c.countriesDispaly.length,
              itemBuilder: (context, index) {
                return CountryItem(c.countriesDispaly[index].country,
                    c.countriesDispaly[index].padding);
              },
            ),
    );
  }

  Widget CountriesLoading() {
    return Container(
      width: Get.width,
      height: Get.height * 0.2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CountryLoading(10),
          CountryLoading(10),
        ],
      ),
    );
  }
}
