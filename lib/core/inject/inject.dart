import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../app/domain/repositories/repositories.dart';
import '../../app/domain/use_cases/use_cases.dart';
import '../../app/data/data_sources/data_sources.dart';
import '../../app/data/repositories/repositories.dart';
import '../../app/presenter/blocs/get_movies/get_movies.dart';
import '../../app/presenter/blocs/selected_movie/selected_movie.dart';

import '../helpers/http/http.dart';

class Inject {
  static initialize() {
    GetIt getIt = GetIt.instance;

    // core
    getIt.registerLazySingleton<Dio>(() => Dio());
    getIt.registerLazySingleton<Interceptor>(() => CustomInterceptor());
    getIt.registerLazySingleton<HttpHelper>(
      () => HttpHelperImpl(getIt(), getIt()),
    );

    // dataSources
    getIt.registerLazySingleton<MovieDataSource>(
      () => MovieDataSourceImpl(getIt()),
    );

    // repositories
    getIt.registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(getIt()),
    );

    // useCases
    getIt.registerLazySingleton<GetMoviesUseCase>(
      () => GetMoviesUseCaseImpl(getIt()),
    );

    // blocs
    getIt.registerFactory<GetMoviesBloc>(
      () => GetMoviesBloc(getIt()),
    );
    getIt.registerFactory<SelectedMovieBloc>(
      () => SelectedMovieBloc(),
    );
  }
}
