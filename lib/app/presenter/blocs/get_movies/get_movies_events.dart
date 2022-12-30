import 'package:equatable/equatable.dart';

abstract class GetMoviesEvent extends Equatable {
  const GetMoviesEvent();
}

class GetMoviesWithFilterEvent extends GetMoviesEvent {
  final String exampleFilter;

  const GetMoviesWithFilterEvent({required this.exampleFilter});

  @override
  List<Object> get props => [exampleFilter];
}
