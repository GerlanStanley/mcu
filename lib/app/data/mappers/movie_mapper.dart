import '../../domain/entities/entities.dart';

class MovieMapper {
  static List<MovieEntity> fromList(List list) {
    return list.map((element) => fromMap(element)).toList();
  }

  static MovieEntity fromMap(Map json) {
    return MovieEntity(
      id: json["id"],
      title: json["title"],
      overview: json["overview"],
      voteAverage: json["vote_average"].toDouble(),
      voteCount: json["vote_count"],
      posterPath: json["poster_path"],
      backdropPath: json["backdrop_path"],
      releaseDate: DateTime.parse(json["release_date"]),
    );
  }
}
