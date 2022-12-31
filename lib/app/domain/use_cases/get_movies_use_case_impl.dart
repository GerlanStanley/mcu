import 'package:dartz/dartz.dart';

import '../../../core/failures/failures.dart';

import '../entities/entities.dart';
import '../failures/failures.dart';
import '../params/params.dart';
import '../repositories/repositories.dart';

import 'use_cases.dart';

class GetMoviesUseCaseImpl implements GetMoviesUseCase {
  final MovieRepository _repository;

  GetMoviesUseCaseImpl(this._repository);

  @override
  Future<Either<Failure, List<MovieEntity>>> call({
    required GetMoviesParams params,
  }) async {
    if (params.exampleFilter.trim().isEmpty) {
      return Left(EmptyFilterGetMoviesFailure(
        message: "Informe o filtro",
      ));
    }

    return await _repository.getAll(params: params);
  }
}
