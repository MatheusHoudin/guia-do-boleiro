import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guia_do_boleiro/core/constants/assets.dart';
import 'package:guia_do_boleiro/core/constants/colors.dart';
import 'package:guia_do_boleiro/core/constants/texts.dart';
import 'package:guia_do_boleiro/features/get_seasons/domain/controller/get_seasons_controller.dart';
import 'package:guia_do_boleiro/features/get_seasons/presentation/widgets/seasons_dropdown.dart';
import 'package:guia_do_boleiro/features/pick_country/domain/controller/get_countries_controller.dart';
import 'package:guia_do_boleiro/shared/model/country.dart';
import 'package:guia_do_boleiro/shared/widgets/custom_search.dart';
import 'package:guia_do_boleiro/shared/widgets/loading_ball.dart';

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
                flex: 1,
                child: Search(),
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
                  child: GetBuilder<GetCountriesController>(
                      builder: (c) => Visibility(
                            visible: !c.isLoadingCountries.value,
                            child: ContinueButton(),
                          )))
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
        onPressed: () => GetCountriesController.to
            .continueToCountryLeaguesPage(GetSeasonsController.to.season),
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

  Widget AppIconAndName() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 30, bottom: 10),
          child: Image.asset(
            appIcon,
            scale: 3,
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

  Widget CountryLoading() {
    return Center(
      child: LoadingBall(
        size: 60,
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
              child: Hero(
                tag: country.country,
                child: ClipRRect(
                  child: SvgPicture.network(
                    country.flagUrl,
                    fit: BoxFit.fill,
                    placeholderBuilder: (context) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: LoadingBall(
                        size: 60,
                      ),
                    ),
                  ),
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

  Widget Search() {
    return Container(
      margin: EdgeInsets.only(
        left: 20,
        right: 20
      ),
      child: CustomSearch(
        controller: GetCountriesController.to.countriesFilterController,
        onChanged: (filter) => GetCountriesController.to.filterCountries(filter),
        hint: pickCountryCountriesFilterHint,
      ),
    );
  }

  Widget CountriesScrollableView() {
    return GetBuilder<GetCountriesController>(
      initState: (_) => GetCountriesController.to.fetchCountries(),
      builder: (c) => c.isLoadingCountries.value
          ? CountryLoading()
          : PageView.builder(
              onPageChanged: (page) => c.onSelectCountry(page),
              controller: pageViewController,
              scrollDirection: Axis.horizontal,
              itemCount: c.countriesDispalyFiltered.length,
              itemBuilder: (context, index) {
                return CountryItem(c.countriesDispalyFiltered[index].country,
                    c.countriesDispalyFiltered[index].padding);
              },
            ),
    );
  }
}
