import 'package:equatable/equatable.dart';

class FixtureEvent extends Equatable {
  final int elapsed;
  final int elapsedPlus;
  final int teamId;
  final String teamName;
  final int playerId;
  final String player;
  final int assistId;
  final String assist;
  final String type;
  final String detail;
  final String comments;

  FixtureEvent({
    this.elapsed,
    this.elapsedPlus,
    this.teamId,
    this.teamName,
    this.playerId,
    this.player,
    this.assistId,
    this.assist,
    this.type,
    this.detail,
    this.comments
  });

  factory FixtureEvent.fromjson(Map<String, dynamic> json) {
    return FixtureEvent(
      elapsed: json['elapsed'],
      elapsedPlus: json['elapsed_plus'],
      teamId: json['team_id'],
      teamName: json['teamName'],
      playerId: json['player_id'],
      player: json['player'],
      assistId: json['assist_id'],
      assist: json['assist'],
      type: json['type'],
      detail: json['detail'],
      comments: json['comments']
    );
  }

  @override
  List<Object> get props => [
    this.elapsed,
    this.elapsedPlus,
    this.teamId,
    this.teamName,
    this.playerId,
    this.player,
    this.assistId,
    this.assist,
    this.type,
    this.detail,
    this.comments
  ];

  @override
  String toString() {
    return 'FixtureEvent{elapsed: $elapsed, elapsedPlus: $elapsedPlus, teamId: $teamId, teamName: $teamName, playerId: $playerId, player: $player, assistId: $assistId, assist: $assist, type: $type, detail: $detail, comments: $comments}';
  }
}
