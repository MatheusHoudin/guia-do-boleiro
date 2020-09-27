import 'package:guia_do_boleiro/core/error/exception/exception.dart';
import 'package:guia_do_boleiro/core/network/network_info.dart';
import 'package:guia_do_boleiro/shared/datasource/country/get/get_country_remote_data_source.dart';
import 'package:guia_do_boleiro/shared/model/country.dart';
import 'package:dartz/dartz.dart';
import 'package:guia_do_boleiro/core/error/failure/failure.dart';

abstract class GetCountryRepository {
  Future<Either<Failure,List<Country>>> getCountries();
}

class GetCountryRepositoryImpl extends GetCountryRepository {
  final NetworkInfo networkInfo;
  final GetCountryRemoteDataSource remoteDataSource;

  GetCountryRepositoryImpl({this.remoteDataSource,this.networkInfo});

  @override
  Future<Either<Failure, List<Country>>> getCountries() async{
    try {
      if(await networkInfo.isConnected) {
        final countriesList = await remoteDataSource.getCountries();

        return Right(countriesList);
      }else{
        return Left(NoInternetConnectionFailure());
      }
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
