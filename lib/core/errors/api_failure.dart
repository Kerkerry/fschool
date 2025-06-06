import 'package:school/core/errors/api_exception.dart';
import 'package:school/core/errors/failure.dart';

class ApiFailure extends Failure{
  const ApiFailure({required super.statusCode, required super.message});
  ApiFailure.fromException(ApiException e):
      this(statusCode: e.statusCode,message: e.message);
}