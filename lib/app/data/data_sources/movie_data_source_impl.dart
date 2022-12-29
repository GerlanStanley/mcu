import '../../../core/failures/failures.dart';
import '../../../core/helpers/http/http.dart';

import '../../domain/entities/entities.dart';
import '../../domain/params/params.dart';

import '../mappers/mappers.dart';

import 'data_sources.dart';

class MovieDataSourceImpl implements MovieDataSource {
  final HttpHelper _httpHelper;

  MovieDataSourceImpl(this._httpHelper);

  @override
  Future<List<MovieEntity>> getAll({
    required GetMoviesParams params,
  }) async {
    try {
      Map response = await _httpHelper.get(
        "/v1/246679d2-5063-466f-84ef-6157bf334da2",
        queryParameters: {
          "example_filter": params.exampleFilter,
        },
      );
      return MovieMapper.fromList(response["mcu"]);
    } on Failure {
      rethrow;
    } catch (e, stackTrace) {
      throw ParseFailure(
        message: "Erro ao mapear o json",
        stackTrace: stackTrace,
      );
    }
  }
}
