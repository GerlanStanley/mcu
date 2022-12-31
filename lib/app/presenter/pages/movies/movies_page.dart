import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../blocs/get_movies/get_movies.dart';
import '../../blocs/selected_movie/selected_movie.dart';
import '../../widgets/widgets.dart';

import 'components/components.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({Key? key}) : super(key: key);

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage>
    with SingleTickerProviderStateMixin {
  //
  var getMoviesBloc = GetIt.I<GetMoviesBloc>();
  var selectedMovieBloc = GetIt.I<SelectedMovieBloc>();

  @override
  void initState() {
    super.initState();

    getMoviesBloc.add(
      const GetMoviesWithFilterEvent(exampleFilter: "filter"),
    );
  }

  @override
  void dispose() {
    getMoviesBloc.close();
    selectedMovieBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      body: Stack(
        children: [
          BlocConsumer<GetMoviesBloc, GetMoviesState>(
            bloc: getMoviesBloc,
            listener: (context, state) {
              if (state is SuccessGetMoviesState) {
                selectedMovieBloc.add(
                  ChangeSelectedMovieEvent(movie: state.movies[0]),
                );
              }
            },
            builder: (context, state) {
              if (state is LoadingGetMoviesState) {
                return const LoadWidget();
              } else if (state is FailureGetMoviesState) {
                return FailureWidget(
                  message: state.error,
                  onPressed: () => getMoviesBloc.add(
                    const GetMoviesWithFilterEvent(exampleFilter: "filter"),
                  ),
                );
              } else if (state is SuccessGetMoviesState) {
                return ContentComponent(
                  movies: state.movies,
                  selectedMovieBloc: selectedMovieBloc,
                );
              }

              return Container();
            },
          ),
          Column(
            children: [
              AppBar(
                title: Image.asset(
                  "assets/images/logo_marvel.png",
                  height: 24,
                ),
                centerTitle: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
