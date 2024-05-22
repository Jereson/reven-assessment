

import 'package:raven_assessment/model/baseModel/failure.dart';
import 'package:raven_assessment/utilities/const_utils.dart';

class ServerException implements Exception {
  final String errorMessage;
  ServerException({this.errorMessage = serverErrorMessage});
  ServerFailure toFailure() => ServerFailure(error: errorMessage);
}

class InputException implements Exception {
  final String? errorMessage;
  InputException({this.errorMessage});
  InputFailure toFailure() => InputFailure(errorMessage: errorMessage);
}

class UnauthorisedException implements Exception {
  final String errorMessage;
  UnauthorisedException({this.errorMessage = ''});
  BadRequestFailure toFailure() => BadRequestFailure(errorMessage: errorMessage);
}

class NetworkException implements Exception {}

class UnknownException implements Exception {}
