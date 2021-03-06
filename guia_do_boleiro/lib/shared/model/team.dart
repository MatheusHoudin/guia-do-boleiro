import 'package:equatable/equatable.dart';

class Team extends Equatable {
  final int id;
  final String name;
  final String logo;

  Team({this.id, this.name, this.logo});

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'],
      name: json['team_name'].toString().length >= 11 ? '${json['team_name'].toString().substring(0,11)}...' : json['team_name'],
      logo: json['logo'],
    );
  }

  @override
  List<Object> get props => [id,name,logo];

  @override
  String toString() {
    return 'Team{id: $id, name: $name, logo: $logo}';
  }
}
