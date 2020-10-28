import 'package:dio/dio.dart';
import 'package:guia_do_boleiro/core/error/exception/exception.dart';

abstract class GetCurrentRoundForLeagueRemoteDataSource {
  Future<String> getCurrentRoundForLeague(int league);
}

class GetCurrentRoundForLeagueRemoteDataSourceImpl
    extends GetCurrentRoundForLeagueRemoteDataSource {
  final Dio client;

  GetCurrentRoundForLeagueRemoteDataSourceImpl({this.client});

  @override
  Future<String> getCurrentRoundForLeague(int league) async {
    try {
      final response = await client.get('fixtures/rounds/$league/current');

      return (response.data['api']['fixtures'] as List)[0];
    } on DioError {
      throw ServerException();
    }
  }
}
