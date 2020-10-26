import 'package:dio/dio.dart';
import 'package:guia_do_boleiro/core/error/exception/exception.dart';

abstract class GetLeagueRoundsRemoteDataSource {
  Future<List<String>> getLeagueRounds(int leagueId);
}

class GetLeagueRoundsRemoteDataSourceImpl
    extends GetLeagueRoundsRemoteDataSource {
  final Dio client;

  GetLeagueRoundsRemoteDataSourceImpl({this.client});

  @override
  Future<List<String>> getLeagueRounds(int leagueId) async {
    try {
      final response = await client.get('fixtures/rounds/$leagueId');

      return (response.data['api']['fixtures'] as List)
          .map((round) => round.toString())
          .toList();
    } on DioError {
      throw ServerException();
    }
  }
}
