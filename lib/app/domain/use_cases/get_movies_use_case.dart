import 'package:dartz/dartz.dart';

import '../../../core/failures/failures.dart';

import '../entities/entities.dart';
import '../params/params.dart';

abstract class GetMoviesUseCase {
  Future<Either<Failure, List<MovieEntity>>> call({
    required GetMoviesParams params,
  });
}
