import 'package:equatable/equatable.dart';

import '../../../domain/entities/entities.dart';

abstract class GetMoviesState extends Equatable {
  const GetMoviesState();
}

class InitialGetMoviesState extends GetMoviesState {
  @override
  List<Object> get props => [];
}

class LoadingGetMoviesState extends GetMoviesState {
  @override
  List<Object> get props => [];
}

class SuccessGetMoviesState extends GetMoviesState {
  final List<MovieEntity> movies;

  const SuccessGetMoviesState({
    required this.movies,
  });

  @override
  List<Object> get props => [];
}

class FailureGetMoviesState extends GetMoviesState {
  final String error;

  const FailureGetMoviesState({required this.error});

  @override
  List<Object> get props => [error];
}
