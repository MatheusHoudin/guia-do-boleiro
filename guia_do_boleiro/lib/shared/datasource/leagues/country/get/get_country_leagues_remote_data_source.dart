import 'package:dio/dio.dart';
import 'package:guia_do_boleiro/core/error/exception/exception.dart';
import 'package:guia_do_boleiro/shared/model/league.dart';

abstract class GetCountryLeaguesRemoteDataSource {
  Future<List<League>> getCountryLeagues(String country, String season);
}

class GetCountryLeaguesRemoteDataSourceImpl
    extends GetCountryLeaguesRemoteDataSource {
  final Dio client;

  GetCountryLeaguesRemoteDataSourceImpl({this.client});

  @override
  Future<List<League>> getCountryLeagues(String country, String season) async {
    try {
      final response = await client.get("leagues/country/$country/$season");

      return (response.data['api']['leagues'] as List).map((l) =>
          League.fromJson(l)).toList();
    } on DioError {
      throw ServerException();
    }
  }
}
