import 'package:dartz/dartz.dart';
import 'package:guia_do_boleiro/core/constants/texts.dart';
import 'package:guia_do_boleiro/core/error/exception/exception.dart';
import 'package:guia_do_boleiro/core/error/failure/failure.dart';
import 'package:guia_do_boleiro/core/network/network_info.dart';
import 'package:guia_do_boleiro/shared/datasource/season/get/get_season_remote_data_source.dart';

abstract class GetSeasonsRepository {
  Future<Either<Failure, List<String>>> getSeasons();
}

class GetSeasonsRepositoryImpl extends GetSeasonsRepository {
  final GetSeasonsRemoteDataSource getSeasonRemoteDataSource;
  final NetworkInfo networkInfo;

  GetSeasonsRepositoryImpl({this.getSeasonRemoteDataSource, this.networkInfo});

  @override
  Future<Either<Failure, List<String>>> getSeasons() async {
    if(await networkInfo.isConnected) {
      try {
        final seasons = await getSeasonRemoteDataSource.getSeasons();
        return Right(seasons);
      } on ServerException {
        return Left(ServerFailure(
          title: getSeasonsRepositoryServerFailureTitle,
          message: getSeasonsRepositoryServerFailureMessage
        ));
      }
    }else{
      return Left(NoInternetConnectionFailure());
    }
  }
}
