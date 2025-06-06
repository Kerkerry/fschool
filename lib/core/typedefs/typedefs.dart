import 'package:dartz/dartz.dart';
import 'package:school/core/errors/failure.dart';

typedef ResultFuture<T>=Future<Either<Failure,T>>;
typedef ResulVoid=ResultFuture<void>;
typedef DataMap=Map<String,dynamic>;