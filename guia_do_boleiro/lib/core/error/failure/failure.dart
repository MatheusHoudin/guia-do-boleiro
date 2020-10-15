import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class NoInternetConnectionFailure extends Failure {

  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {
  final String title;
  final String message;

  ServerFailure({this.message, this.title});

  @override
  List<Object> get props => [message, title];
}
