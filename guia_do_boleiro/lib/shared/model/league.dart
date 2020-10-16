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

  League({
    this.leagueId,
    this.name,
    this.type,
    this.seasonStart,
    this.seasonEnd,
    this.logo,
    this.flag
  });

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      leagueId: json['league_id'],
      name: json['name'],
      type: json['type'],
      seasonStart: formatToBrazilianDate(json['season_start']),
      seasonEnd: formatToBrazilianDate(json['season_end']),
      logo: json['logo'],
      flag: json['flag']
    );
  }

  @override
  List<Object> get props => [];
}
