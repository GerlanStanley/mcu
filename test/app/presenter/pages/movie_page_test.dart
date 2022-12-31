import 'package:bloc_test/bloc_test.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import 'package:mcu/app/domain/entities/entities.dart';
import 'package:mcu/app/presenter/blocs/get_movies/get_movies.dart';
import 'package:mcu/app/presenter/blocs/selected_movie/selected_movie.dart';
import 'package:mcu/app/presenter/pages/movies/components/components.dart';
import 'package:mcu/app/presenter/pages/movies/movies.dart';
import 'package:mcu/app/presenter/widgets/widgets.dart';

class MockGetMoviesBloc extends MockBloc<GetMoviesEvent, GetMoviesState>
    implements GetMoviesBloc {}

class MockSelectedMovieBloc
    extends MockBloc<SelectedMovieEvent, SelectedMovieState>
    implements SelectedMovieBloc {}

void main() {
  MockGetMoviesBloc getMoviesBloc = MockGetMoviesBloc();
  MockSelectedMovieBloc selectedMovieBloc = MockSelectedMovieBloc();
  late MovieEntity movie1;
  late MovieEntity movie2;

  setUpAll(() {
    GetIt.I.registerLazySingleton<GetMoviesBloc>(
      () => getMoviesBloc,
    );

    GetIt.I.registerLazySingleton<SelectedMovieBloc>(
      () => selectedMovieBloc,
    );

    movie1 = MovieEntity(
      id: 1,
      title: faker.lorem.word(),
      overview: faker.lorem.sentence(),
      voteAverage: faker.randomGenerator.decimal(),
      voteCount: faker.randomGenerator.integer(999999),
      posterPath: faker.internet.httpsUrl(),
      backdropPath: faker.internet.httpsUrl(),
      releaseDate: faker.date.dateTime(),
    );

    movie2 = MovieEntity(
      id: 1,
      title: faker.lorem.word(),
      overview: faker.lorem.sentence(),
      voteAverage: faker.randomGenerator.decimal(),
      voteCount: faker.randomGenerator.integer(999999),
      posterPath: faker.internet.httpsUrl(),
      backdropPath: faker.internet.httpsUrl(),
      releaseDate: faker.date.dateTime(),
    );
  });

  tearDown(() {
    getMoviesBloc.close();
    selectedMovieBloc.close();
  });

  testWidgets(
    "Deve exibir o widget LoadWidget quando "
    "o estado do bloc for LoadingGetMoviesState",
    (WidgetTester tester) async {
      when(() => getMoviesBloc.state)
          .thenAnswer((_) => LoadingGetMoviesState());

      await tester.pumpWidget(
        const MaterialApp(
          home: MoviesPage(),
        ),
      );

      final loadWidget = find.byType(LoadWidget);
      final failureWidget = find.byType(FailureWidget);
      final contentComponent = find.byType(ContentComponent);

      await tester.pump();

      expect(loadWidget, findsOneWidget);
      expect(failureWidget, findsNothing);
      expect(contentComponent, findsNothing);
    },
  );

  testWidgets(
    "Deve exibir o widget FailureWidget quando "
    "o estado do bloc for FailureGetMoviesState",
    (WidgetTester tester) async {
      when(() => getMoviesBloc.state)
          .thenAnswer((_) => const FailureGetMoviesState(error: ""));

      await tester.pumpWidget(
        const MaterialApp(
          home: MoviesPage(),
        ),
      );

      final loadWidget = find.byType(LoadWidget);
      final failureWidget = find.byType(FailureWidget);
      final contentComponent = find.byType(ContentComponent);

      await tester.pump();

      expect(loadWidget, findsNothing);
      expect(failureWidget, findsOneWidget);
      expect(contentComponent, findsNothing);
    },
  );

  testWidgets(
    "Deve exibir o widget ChartComponent quando "
    "o estado do bloc for SuccessGetMoviesState",
    (WidgetTester tester) async {
      when(() => getMoviesBloc.state).thenAnswer(
        (_) => SuccessGetMoviesState(
          movies: [movie1, movie2],
        ),
      );

      when(() => selectedMovieBloc.state).thenAnswer(
        (_) => SuccessSelectedMovieState(movie: movie1),
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: MoviesPage(),
        ),
      );

      final loadWidget = find.byType(LoadWidget);
      final failureWidget = find.byType(FailureWidget);
      final contentComponent = find.byType(ContentComponent);

      await tester.pump();

      expect(loadWidget, findsNothing);
      expect(failureWidget, findsNothing);
      expect(contentComponent, findsOneWidget);
    },
  );
}
