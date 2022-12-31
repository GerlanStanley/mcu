import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/entities.dart';

import '../../../blocs/selected_movie/selected_movie.dart';

import 'components.dart';

class ListMoviesComponent extends StatelessWidget {
  final List<MovieEntity> movies;
  final SelectedMovieBloc selectedMovieBloc;
  final double height = 180;

  const ListMoviesComponent({
    Key? key,
    required this.movies,
    required this.selectedMovieBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: selectedMovieBloc,
      builder: (context, state) {
        return SizedBox(
          height: height + 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            padding: const EdgeInsets.only(left: 8, right: 8),
            itemBuilder: (context, index) {
              var movie = movies[index];
              return Container(
                width: height / 1.5,
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: ListMoviesItemComponent(
                  movie: movie,
                  selectedMovie:
                      state is SuccessSelectedMovieState ? state.movie : null,
                  imageHeight: height,
                  onTap: () {
                    selectedMovieBloc.add(
                      ChangeSelectedMovieEvent(movie: movie),
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
