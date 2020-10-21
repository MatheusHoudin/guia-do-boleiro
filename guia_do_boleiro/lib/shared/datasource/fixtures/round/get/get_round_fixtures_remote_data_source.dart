import 'package:dio/dio.dart';
import 'package:guia_do_boleiro/core/error/exception/exception.dart';
import 'package:guia_do_boleiro/shared/model/fixture.dart';

abstract class GetRoundFixturesRemoteDataSource {
  Future<List<Fixture>> getRoundFixtures(String league, String round);
}

class GetRoundFixturesRemoteDataSourceImpl extends GetRoundFixturesRemoteDataSource {
  final Dio client;

  GetRoundFixturesRemoteDataSourceImpl({this.client});

  @override
  Future<List<Fixture>> getRoundFixtures(String league, String round) async {
    try {
      final response = await client.get('fixtures/leagues/$league/$round');

      return (response.data['api']['fixtures'] as List).map((match) => Fixture.fromJson(match)).toList();
    } on DioError {
      throw ServerException();
    }
  }
}
