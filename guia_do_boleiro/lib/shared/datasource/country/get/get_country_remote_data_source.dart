import 'package:dio/dio.dart';
import 'package:guia_do_boleiro/core/error/exception/exception.dart';
import 'package:guia_do_boleiro/shared/model/country.dart';

abstract class GetCountryRemoteDataSource {
  Future<List<Country>> getCountries();
}

class GetCountryRemoteDataSourceImpl extends GetCountryRemoteDataSource {
  final Dio client;

  GetCountryRemoteDataSourceImpl({this.client});

  @override
  Future<List<Country>> getCountries() async {
    try {
      final response = await client.get("countries");

      return (response.data['api']['countries'] as List)
          .map((c) => Country.fromJson(c))
          .toList();
    } on DioError {
      throw ServerException();
    }
  }
}
