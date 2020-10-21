import 'package:dartz/dartz.dart';
import 'package:guia_do_boleiro/core/error/failure/failure.dart';
import 'package:guia_do_boleiro/core/network/network_info.dart';
import 'package:guia_do_boleiro/shared/datasource/fixtures/round/get/get_round_fixtures_remote_data_source.dart';
import 'package:guia_do_boleiro/shared/model/fixture.dart';

abstract class GetRoundFixturesRepository {
  Future<Either<Failure, List<Fixture>>> getRoundFixtures(String league,
      String round);
}

class GetRoundFixturesRepositoryImpl extends GetRoundFixturesRepository {
  final GetRoundFixturesRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  GetRoundFixturesRepositoryImpl({this.remoteDataSource, this.networkInfo});

  @override
  Future<Either<Failure, List<Fixture>>> getRoundFixtures(String league, String round) async {
    if (await networkInfo.isConnected) {
      final response = await remoteDataSource.getRoundFixtures(league, round);
      return Right(response);
    } else {
      return Left(NoInternetConnectionFailure());
    }
  }
}
