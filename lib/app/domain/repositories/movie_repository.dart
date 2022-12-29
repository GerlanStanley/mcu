import 'package:dartz/dartz.dart';

import '../../../core/failures/failures.dart';

import '../entities/entities.dart';
import '../params/params.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<MovieEntity>>> getAll({
    required GetMoviesParams params,
  });
}