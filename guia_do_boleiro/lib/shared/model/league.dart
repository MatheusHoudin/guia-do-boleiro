import 'package:equatable/equatable.dart';
import 'package:guia_do_boleiro/core/formatter.dart';

class League extends Equatable {
  final int leagueId;
  final String name;
  final String type;
  final String seasonStart;
  final String seasonEnd;
  final String logo;
  final String flag;
  final String country;

  League({
    this.leagueId,
    this.name,
    this.type,
    this.seasonStart,
    this.seasonEnd,
    this.logo,
    this.flag,
    this.country
  });

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      leagueId: json['league_id'],
      name: json['name'],
      type: json['type'],
      seasonStart: json['season_start'].toString().isNotEmpty ? formatToBrazilianDate(json['season_start']) : null,
      seasonEnd: json['season_end'].toString().isNotEmpty ? formatToBrazilianDate(json['season_end']) : null,
      logo: json['logo'],
      flag: json['flag'],
      country: json['country']
    );
  }

  @override
  List<Object> get props => [leagueId, name, type, seasonStart, seasonEnd, logo, flag, country];
}
