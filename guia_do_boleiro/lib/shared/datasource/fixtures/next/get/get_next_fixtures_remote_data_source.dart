import 'package:dio/dio.dart';
import 'package:guia_do_boleiro/core/error/exception/exception.dart';
import 'package:guia_do_boleiro/shared/model/fixture.dart';

abstract class GetNextFixturesRemoteDataSource {
  Future<List<Fixture>> getNextFixtures(int leagueId);
}

class GetNextFixturesRemoteDataSourceImpl
    extends GetNextFixturesRemoteDataSource {
  final Dio client;

  GetNextFixturesRemoteDataSourceImpl({this.client});

  @override
  Future<List<Fixture>> getNextFixtures(int leagueId) async {
    try {
      final response =
          await client.get("fixtures/league/$leagueId/next/10");

      var fixtures = (response.data['api']['fixtures'] as List)
          .map((fixture) => Fixture.fromJson(fixture))
          .toList();
      return fixtures;
    } on DioError {
      throw ServerException();
    }
  }
}
