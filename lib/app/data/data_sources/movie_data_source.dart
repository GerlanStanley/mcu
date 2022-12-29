import '../../domain/entities/entities.dart';
import '../../domain/params/params.dart';

abstract class MovieDataSource {
  Future<List<MovieEntity>> getAll({
    required GetMoviesParams params,
  });
}
