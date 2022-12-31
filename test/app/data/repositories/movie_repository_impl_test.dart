import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:mcu/app/domain/params/params.dart';
import 'package:mcu/app/domain/entities/entities.dart';
import 'package:mcu/app/data/data_sources/data_sources.dart';
import 'package:mcu/app/data/repositories/repositories.dart';
import 'package:mcu/core/failures/failures.dart';

class MockMovieDataSource extends Mock implements MovieDataSource {}

void main() {
  late MockMovieDataSource dataSource;
  late MovieRepositoryImpl repository;
  late GetMoviesParams params;

  setUp(() {
    dataSource = MockMovieDataSource();
    repository = MovieRepositoryImpl(dataSource);
    params = GetMoviesParams(exampleFilter: "teste");

    registerFallbackValue(params);
  });

  test(
    "Deve retornar uma List<MovieEntity> quando o datasource retornar o objeto",
    () async {
      when(() => dataSource.getAll(params: any(named: "params")))
          .thenAnswer((_) async => []);

      var result = await repository.getAll(params: params);

      expect(result.fold(id, id), isA<List<MovieEntity>>());
    },
  );

  test(
    "Deve retornar um Failure quando o datasource throws Failure",
    () async {
      when(() => dataSource.getAll(params: any(named: "params")))
          .thenThrow(Failure(message: ""));

      var result = await repository.getAll(params: params);

      expect(result.fold(id, id), isA<Failure>());
    },
  );
}
