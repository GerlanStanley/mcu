import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/constants.dart';

import '../../../../domain/entities/entities.dart';

import '../../../blocs/selected_movie/selected_movie.dart';
import '../../../widgets/widgets.dart';

import 'components.dart';

class ContentComponent extends StatelessWidget {
  final List<MovieEntity> movies;
  final SelectedMovieBloc selectedMovieBloc;

  const ContentComponent({
    Key? key,
    required this.movies,
    required this.selectedMovieBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        BlocBuilder(
          bloc: selectedMovieBloc,
          builder: (context, state) {
            if (state is SuccessSelectedMovieState) {
              return CachedNetworkImageWidget(
                image: ApiConstants.imageUrlPrefix + state.movie.backdropPath,
                fit: BoxFit.cover,
              );
            }
            return Container();
          },
        ),
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.transparent,
                Colors.transparent,
                Colors.transparent,
                Colors.black,
                Colors.black,
                Colors.black,
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BlocBuilder(
                bloc: selectedMovieBloc,
                builder: (context, state) {
                  if (state is SuccessSelectedMovieState) {
                    return Container(
                      margin: const EdgeInsets.only(
                        left: 16,
                        right: 80,
                        bottom: 40,
                      ),
                      child: Text(
                        state.movie.title.toUpperCase(),
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    );
                  }
                  return Container();
                },
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 12,
                ),
                child: Text(
                  "LINHA DO TEMPO",
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
              ListMoviesComponent(
                movies: movies,
                selectedMovieBloc: selectedMovieBloc,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
