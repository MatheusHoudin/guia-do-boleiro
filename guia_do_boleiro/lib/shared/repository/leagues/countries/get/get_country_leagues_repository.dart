import 'package:dartz/dartz.dart';
import 'package:guia_do_boleiro/core/error/exception/exception.dart';
import 'package:guia_do_boleiro/core/error/failure/failure.dart';
import 'package:guia_do_boleiro/core/network/network_info.dart';
import 'package:guia_do_boleiro/shared/datasource/leagues/countries/get/get_country_leagues_remote_data_source.dart';
import 'package:guia_do_boleiro/shared/model/league.dart';
import 'package:guia_do_boleiro/core/constants/texts.dart';

abstract class GetCountryLeaguesRepository {
  Future<Either<Failure,List<League>>> getLeagues(String country, String season);
}

class GetCountryLeaguesRepositoryImpl extends GetCountryLeaguesRepository {
  final NetworkInfo networkInfo;
  final GetCountryLeaguesRemoteDataSourceImpl remoteDataSourceImpl;

  GetCountryLeaguesRepositoryImpl({this.networkInfo, this.remoteDataSourceImpl});

  @override
  Future<Either<Failure, List<League>>> getLeagues(String country, String season) async {
    if (await networkInfo.isConnected) {
      try {
        final countryLeagues = await remoteDataSourceImpl.getCountryLeagues(country, season);
        return Right(countryLeagues);
      } on ServerException {
        return Left(ServerFailure(
          title: getCountrySeasonsRepositoryServerFailureTitle,
          message: getCountrySeasonsRepositoryServerFailureMessage
        ));
      }
    }else{
      return Left(NoInternetConnectionFailure());
    }
  }
}
