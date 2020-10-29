import 'package:equatable/equatable.dart';

class LeagueTab extends Equatable {
  String text;
  Function onClick;

  LeagueTab({this.onClick, this.text});

  @override
  List<Object> get props => [text, onClick];
}
