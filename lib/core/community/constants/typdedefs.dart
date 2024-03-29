import 'package:fpdart/fpdart.dart';
import 'package:gonomad/core/community/constants/failure.dart';


typedef FutureEither<T>=Future<Either<Failure,T>>;
typedef FutureVoid = FutureEither<void>;