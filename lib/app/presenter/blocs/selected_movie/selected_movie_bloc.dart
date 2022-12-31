import 'package:flutter_bloc/flutter_bloc.dart';

import 'selected_movie.dart';

class SelectedMovieBloc extends Bloc<SelectedMovieEvent, SelectedMovieState> {
  SelectedMovieBloc() : super(InitialSelectedMovieState()) {
    on<ChangeSelectedMovieEvent>(_onChange);
  }

  Future<void> _onChange(
    ChangeSelectedMovieEvent event,
    Emitter<SelectedMovieState> emit,
  ) async {
    emit(SuccessSelectedMovieState(movie: event.movie));
  }
}
