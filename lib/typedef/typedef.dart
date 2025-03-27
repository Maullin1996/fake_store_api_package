import 'package:dartz/dartz.dart';
import 'package:fake_store_api_package/errors/structure/failure.dart';

/// A typedef for a [Future] that returns an [Either] type.
///
/// The [Either] type contains a [Failure] on the left side and a generic type [T] on the right side.
typedef FutureResult<T> = Future<Either<Failure, T>>;
