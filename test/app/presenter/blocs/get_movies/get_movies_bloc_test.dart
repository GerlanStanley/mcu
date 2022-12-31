import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:mcu/app/domain/params/params.dart';
import 'package:mcu/app/domain/entities/entities.dart';
import 'package:mcu/app/domain/use_cases/use_cases.dart';
import 'package:mcu/app/presenter/blocs/get_movies/get_movies.dart';
import 'package:mcu/core/failures/failures.dart';

class MockGetMoviesUseCase extends Mock implements GetMoviesUseCase {}

void main() {
  late MockGetMoviesUseCase useCase;
  late GetMoviesBloc bloc;
  late GetMoviesParams params;

  setUp(() {
    useCase = MockGetMoviesUseCase();
    bloc = GetMoviesBloc(useCase);
    params = GetMoviesParams(exampleFilter: "teste");

    registerFallbackValue(params);
  });

  tearDown(() {
    bloc.close();
  });

  blocTest(
    "Quando o useCase retornar um sucesso o "
    "bloc deve iniciar carregando e terminar com sucesso",
    build: () {
      when(() => useCase.call(params: any(named: "params"))).thenAnswer(
        (_) async => const Right<Failure, List<MovieEntity>>([]),
      );
      return bloc;
    },
    act: (GetMoviesBloc bloc) {
      bloc.add(const GetMoviesWithFilterEvent(exampleFilter: "teste"));
    },
    expect: () => [
      isA<LoadingGetMoviesState>(),
      isA<SuccessGetMoviesState>(),
    ],
  );

  blocTest(
    "Quando o useCase retornar uma falha o "
    "bloc deve iniciar carregando e terminar com falha",
    build: () {
      when(() => useCase.call(params: any(named: "params"))).thenAnswer(
        (_) async => Left<Failure, List<MovieEntity>>(
          Failure(message: ""),
        ),
      );
      return bloc;
    },
    act: (GetMoviesBloc bloc) {
      bloc.add(const GetMoviesWithFilterEvent(exampleFilter: "teste"));
    },
    expect: () => [
      isA<LoadingGetMoviesState>(),
      isA<FailureGetMoviesState>(),
    ],
  );
}
