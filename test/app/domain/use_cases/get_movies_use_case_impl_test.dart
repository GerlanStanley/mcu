import 'package:dartz/dartz.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:mcu/app/domain/repositories/repositories.dart';
import 'package:mcu/app/domain/use_cases/use_cases.dart';
import 'package:mcu/app/domain/params/params.dart';
import 'package:mcu/app/domain/entities/entities.dart';
import 'package:mcu/app/domain/failures/failures.dart';
import 'package:mcu/core/failures/failures.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  late MockMovieRepository repository;
  late GetMoviesUseCaseImpl useCase;

  setUp(() {
    repository = MockMovieRepository();
    useCase = GetMoviesUseCaseImpl(repository);

    registerFallbackValue(GetMoviesParams(exampleFilter: "Teste"));
  });

  test(
    "Deve retornar um Right(List<MovieEntity>) quando o repository "
    "retornar um Right(List<MovieEntity>)",
    () async {
      var params = GetMoviesParams(exampleFilter: "Teste");
      when(
        () => repository.getAll(params: any(named: "params")),
      ).thenAnswer((_) async {
        List<MovieEntity> items = [];
        for (int i = 0; i < 3; i++) {
          items.add(MovieEntity(
            id: faker.randomGenerator.integer(999),
            title: faker.company.name(),
            overview: faker.lorem.sentence(),
            voteAverage: faker.randomGenerator.decimal(),
            voteCount: faker.randomGenerator.integer(99999),
            posterPath: faker.internet.httpsUrl(),
            backdropPath: faker.internet.httpsUrl(),
            releaseDate: faker.date.dateTime(),
          ));
        }

        return Right(items);
      });

      var result = await useCase(params: params);

      expect(result.fold(id, id), isA<List<MovieEntity>>());
    },
  );

  test(
    "Deve retornar um Left(EmptyFilterGetMoviesFailure) "
    "quando o filtro for vazio",
    () async {
      var params = GetMoviesParams(exampleFilter: "");

      var result = await useCase(params: params);

      expect(result.fold(id, id), isA<EmptyFilterGetMoviesFailure>());
    },
  );

  test(
    "Deve retornar um Left(Failure) quando o repository "
    "retornar um Left(Failure)",
    () async {
      var params = GetMoviesParams(exampleFilter: "Teste");

      when(
        () => repository.getAll(params: any(named: "params")),
      ).thenAnswer((_) async {
        return Left(Failure(message: ""));
      });

      var result = await useCase(params: params);

      expect(result.fold(id, id), isA<Failure>());
    },
  );
}
