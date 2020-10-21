import 'package:equatable/equatable.dart';
import 'package:guia_do_boleiro/shared/model/fixture_event.dart';
import 'package:guia_do_boleiro/shared/model/league.dart';
import 'package:guia_do_boleiro/shared/model/score.dart';
import 'package:guia_do_boleiro/shared/model/team.dart';

class Fixture extends Equatable {
  final int fixtureId;
  final int leagueId;
  final League league;
  final Team homeTeam;
  final Team awayTeam;
  final String eventDate;
  final String round;
  final String status;
  final int elapsed;
  final String venue;
  final String referee;
  final int goalsHomeTeam;
  final int goalsAwayTeam;
  final Score score;
  final List<FixtureEvent> fixtureEvents;

  Fixture({
    this.fixtureId,
    this.leagueId,
    this.league,
    this.homeTeam,
    this.awayTeam,
    this.eventDate,
    this.round,
    this.status,
    this.elapsed,
    this.venue,
    this.referee,
    this.goalsHomeTeam,
    this.goalsAwayTeam,
    this.score,
    this.fixtureEvents
  });

  factory Fixture.fromJson(Map<String, dynamic> json) {
    return Fixture(
      fixtureId: json['fixture_id'],
      leagueId: json['league_id'],
      league: League.fromJson(json['league']),
      homeTeam: Team.fromJson(json['homeTeam']),
      awayTeam: Team.fromJson(json['awayTeam']),
      eventDate: json['event_date'],
      round: json['round'],
      status: json['status'],
      elapsed: json['elapsed'],
      venue: json['venue'],
      referee: json['referee'],
      score: Score.fromJson(json['score']),
      goalsAwayTeam: json['goalsAwayTeam'],
      goalsHomeTeam: json['goalsHomeTeam'],
      fixtureEvents: json['events'] != null ? (json['events'] as List).map((event) => FixtureEvent.fromjson(event)) : null
    );
  }

  @override
  List<Object> get props => [
        fixtureId,
        league,
        leagueId,
        homeTeam,
        awayTeam,
        eventDate,
        round,
        status,
        elapsed,
        venue,
        referee,
        goalsAwayTeam,
        goalsHomeTeam,
        score
      ];
}
