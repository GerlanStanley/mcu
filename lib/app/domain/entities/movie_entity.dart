class MovieEntity {
  final int id;
  final String title;
  final String overview;
  final int voteAverage;
  final int voteCount;
  final String posterPath;
  final String backdropPath;
  final DateTime releaseDate;

  MovieEntity({
    required this.id,
    required this.title,
    required this.overview,
    required this.voteAverage,
    required this.voteCount,
    required this.posterPath,
    required this.backdropPath,
    required this.releaseDate,
  });
}
