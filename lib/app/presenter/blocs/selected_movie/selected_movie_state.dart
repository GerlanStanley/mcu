import 'package:equatable/equatable.dart';

import '../../../domain/entities/entities.dart';

abstract class SelectedMovieState extends Equatable {
  const SelectedMovieState();
}

class InitialSelectedMovieState extends SelectedMovieState {
  @override
  List<Object> get props => [];
}

class SuccessSelectedMovieState extends SelectedMovieState {
  final MovieEntity movie;

  const SuccessSelectedMovieState({
    required this.movie,
  });

  @override
  List<Object> get props => [movie];
}
