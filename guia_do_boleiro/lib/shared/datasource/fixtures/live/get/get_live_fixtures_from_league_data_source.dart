import 'package:dio/dio.dart';
import 'package:guia_do_boleiro/core/error/exception/exception.dart';
import 'package:guia_do_boleiro/shared/model/fixture.dart';

abstract class GetLiveFixturesFromLeagueRemoteDataSource {
  Future<List<Fixture>> getLiveFixturesFromLeague(int leagueId);
}

class GetLiveFixturesFromLeagueRemoteDataSourceImpl
    extends GetLiveFixturesFromLeagueRemoteDataSource {
  final Dio client;

  GetLiveFixturesFromLeagueRemoteDataSourceImpl({this.client});

  @override
  Future<List<Fixture>> getLiveFixturesFromLeague(int leagueId) async {
    try {
      var result = await client.get("fixtures/live/$leagueId}");
      var fixtures = (result.data['api']['fixtures'] as List)
          .map((fixture) => Fixture.fromJson(fixture))
          .toList();
      return fixtures;
    } on DioError {
      throw ServerException();
    }
  }
}
