import 'package:dio/dio.dart';
import 'package:guia_do_boleiro/core/error/exception/exception.dart';
import 'package:guia_do_boleiro/shared/model/fixture.dart';

abstract class GetTodayFixturesRemoteDataSource {
  Future<List<Fixture>> getFixturesFromToday(int leagueId);
}

class GetTodayFixturesRemoteDataSourceImpl
    extends GetTodayFixturesRemoteDataSource {
  final Dio client;

  GetTodayFixturesRemoteDataSourceImpl({this.client});

  @override
  Future<List<Fixture>> getFixturesFromToday(int leagueId) async {
    try {
      var today = DateTime.now();
      var formattedToday = '${today.year}/${today.month}/${today.day}';

      final response =
          await client.get("fixtures/league/$leagueId/$formattedToday");

      var fixtures = (response.data['api']['fixtures'] as List)
          .map((fixture) => Fixture.fromJson(fixture))
          .toList();
      return fixtures;
    } on DioError {
      throw ServerException();
    }
  }
}
