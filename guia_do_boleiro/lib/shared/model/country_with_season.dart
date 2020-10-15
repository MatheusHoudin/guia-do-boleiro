import 'package:equatable/equatable.dart';
import 'package:guia_do_boleiro/shared/model/country.dart';

class CountryWithSeason extends Equatable {
  final Country country;
  final String season;

  CountryWithSeason({this.country, this.season});

  @override
  List<Object> get props => [country, season];

}
