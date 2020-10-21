import 'package:equatable/equatable.dart';

class Score extends Equatable {
  final String fulltime;
  final String halfTime;
  final String extraTime;
  final String penalty;

  Score({this.extraTime,this.fulltime,this.halfTime,this.penalty});

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      fulltime: json['fulltime'],
      halfTime: json['halftime'],
      extraTime: json['extratime'],
      penalty: json['penalty']
    );
  }
  @override
  List<Object> get props => [extraTime, fulltime, halfTime, penalty];
}
