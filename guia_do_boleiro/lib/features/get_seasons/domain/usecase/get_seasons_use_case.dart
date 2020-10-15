import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:guia_do_boleiro/core/error/failure/failure.dart';
import 'package:guia_do_boleiro/core/usecase/base_use_case.dart';
import 'package:guia_do_boleiro/shared/repository/season/get/get_seasons_repository.dart';

class GetSeasonsUseCase extends BaseUseCase<List<String>,GetSeasonsParams> {
  final GetSeasonsRepository repository;

  GetSeasonsUseCase({this.repository});

  @override
  Future<Either<Failure, List<String>>> call(GetSeasonsParams params) async {
    return await repository.getSeasons();
  }
}

class GetSeasonsParams extends Equatable {
  @override
  List<Object> get props => [];
}
