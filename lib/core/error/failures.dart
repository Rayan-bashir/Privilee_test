import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? message;

  const Failure({this.message});

  @override
  List<Object?> get props => [message];
}

class DioFailure extends Failure {
  const DioFailure({String? message});
}


class ServerFailure extends Failure {
  const ServerFailure({String? message});
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure();
}

class NoItemsFoundFailure extends Failure {
  const NoItemsFoundFailure();
}
