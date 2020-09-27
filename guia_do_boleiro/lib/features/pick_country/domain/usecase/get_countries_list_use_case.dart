import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:guia_do_boleiro/core/error/failure/failure.dart';
import 'package:guia_do_boleiro/core/usecase/base_use_case.dart';
import 'package:guia_do_boleiro/shared/model/country.dart';
import 'package:guia_do_boleiro/shared/repository/country/get/get_country_repository.dart';
class GetCountriesListUseCase
    extends BaseUseCase<List<Country>, GetCountriesParams> {
  final GetCountryRepository getCountryRepository;

  GetCountriesListUseCase({this.getCountryRepository});

  @override
  Future<Either<Failure, List<Country>>> call(GetCountriesParams params) async{
    return await getCountryRepository.getCountries();
  }
}

class GetCountriesParams extends Equatable {
  @override
  List<Object> get props => [];
}
