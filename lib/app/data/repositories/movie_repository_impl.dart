import 'package:dartz/dartz.dart';

import '../../../core/failures/failure.dart';

import '../../domain/entities/entities.dart';
import '../../domain/params/params.dart';
import '../../domain/repositories/repositories.dart';

import '../data_sources/data_sources.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieDataSource _dataSource;

  MovieRepositoryImpl(
    this._dataSource,
  );

  @override
  Future<Either<Failure, List<MovieEntity>>> getAll({
    required GetMoviesParams params,
  }) async {
    try {
      var result = await _dataSource.getAll(params: params);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
