import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../app/domain/repositories/repositories.dart';
import '../../app/domain/use_cases/use_cases.dart';
import '../../app/external/data_sources/data_sources.dart';
import '../../app/infra/data_sources/data_sources.dart';
import '../../app/infra/repositories/repositories.dart';
import '../../app/presenter/blocs/financial_asset/financial_asset.dart';

import '../../app/presenter/blocs/variation/variation.dart';
import '../helpers/http/http.dart';

class Inject {
  static initialize() {
    GetIt getIt = GetIt.instance;

    // core
    getIt.registerLazySingleton<Dio>(() => Dio());
    getIt.registerLazySingleton<Interceptor>(() => CustomInterceptor());
    getIt.registerLazySingleton<HttpHelper>(
      () => HttpHelperImpl(getIt(), getIt()),
    );

    // dataSources
    getIt.registerLazySingleton<FinancialAssetDataSource>(
      () => FinancialAssetDataSourceImpl(getIt()),
    );

    // repositories
    getIt.registerLazySingleton<FinancialAssetRepository>(
      () => FinancialAssetRepositoryImpl(getIt()),
    );

    // useCases
    getIt.registerLazySingleton<SearchFinancialAssetsUseCase>(
      () => SearchFinancialAssetsUseCaseImpl(getIt()),
    );

    // blocs
    getIt.registerLazySingleton<FinancialAssetBloc>(
      () => FinancialAssetBloc(getIt()),
    );
  }
}
