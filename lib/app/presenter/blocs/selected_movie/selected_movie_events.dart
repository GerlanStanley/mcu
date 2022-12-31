import 'package:equatable/equatable.dart';

import '../../../domain/entities/entities.dart';

abstract class SelectedMovieEvent extends Equatable {
  const SelectedMovieEvent();
}

class ChangeSelectedMovieEvent extends SelectedMovieEvent {
  final MovieEntity movie;

  const ChangeSelectedMovieEvent({required this.movie});

  @override
  List<Object> get props => [movie];
}
