import 'package:dartz/dartz.dart';
import 'package:guia_do_boleiro/core/error/failure/failure.dart';

abstract class BaseUseCase<Type,Params> {
  Future<Either<Failure,Type>> call(Params params);
}
