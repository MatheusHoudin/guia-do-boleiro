import 'package:dio/dio.dart';
import 'package:guia_do_boleiro/core/error/exception/exception.dart';

abstract class GetSeasonsRemoteDataSource {
  Future<List<String>> getSeasons();
}

class GetSeasonsRemoteDataSourceImpl extends GetSeasonsRemoteDataSource {
  final Dio client;

  GetSeasonsRemoteDataSourceImpl({this.client});

  @override
  Future<List<String>> getSeasons() async {
    try {
      final response = await client.get("seasons");

      return (response.data['api']['seasons'] as List)
          .map((e) => e.toString())
          .toList();
    } on DioError {
      throw ServerException();
    }
  }
}
