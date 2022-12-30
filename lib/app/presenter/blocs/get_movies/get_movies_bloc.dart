import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/params/params.dart';
import '../../../domain/use_cases/use_cases.dart';

import 'get_movies.dart';

class GetMoviesBloc extends Bloc<GetMoviesEvent, GetMoviesState> {
  final GetMoviesUseCase _getMovies;

  GetMoviesBloc(this._getMovies)
      : super(InitialGetMoviesState()) {
    //
    on<GetMoviesWithFilterEvent>(_onGetAll);
  }

  Future<void> _onGetAll(
    GetMoviesWithFilterEvent event,
    Emitter<GetMoviesState> emit,
  ) async {
    emit(LoadingGetMoviesState());

    var result = await _getMovies(
      params: GetMoviesParams(exampleFilter: event.exampleFilter),
    );

    result.fold((left) {
      emit(FailureGetMoviesState(error: left.message));
    }, (right) async {
      emit(SuccessGetMoviesState(movies: right));
    });
  }
}
