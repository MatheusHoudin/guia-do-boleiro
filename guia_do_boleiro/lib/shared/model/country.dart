import 'package:equatable/equatable.dart';

class Country extends Equatable {
  final String country;
  final String code;
  final String flagUrl;

  Country({this.code,this.country,this.flagUrl});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      code: json['code'],
      country: json['country'],
      flagUrl: json['flag'] != null ? json['flag'] : 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/24/The_world_flag_2006.svg/2096px-The_world_flag_2006.svg.png'
    );
  }

  @override
  List<Object> get props => [this.flagUrl,this.code,this.country];
}
