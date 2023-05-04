import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/data_sources/remote_data_source.dart';
import '../data/network/app_api.dart';
import '../data/network/dio_factory.dart';
import '../data/network/network_info.dart';
import '../data/repository_impl/repository_impl.dart';
import '../domain/repository/repository.dart';
import '../domain/usecases/login_usecase.dart';
import '../presentation/login/view_model/login_view_model.dart';
import 'app_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  // app module, its a module where we put all generic dependencies

  // shared prefs instance
  final sharedPrefs = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // app prefs instance
  instance.registerLazySingleton<AppPreferences>(
      () => AppPreferences(sharedPreferences: instance()));

  // network info
  instance.registerLazySingleton<NetworkInfo>(() =>
      NetworkInfoImpl(internetConnectionChecker: InternetConnectionChecker()));

  // dio factory
  instance.registerLazySingleton<DioFactory>(
      () => DioFactory(appPreferences: instance()));

  Dio dio = await instance<DioFactory>().getDio();
  //app service client
  instance.registerLazySingleton<AppServiceClient>(
      () => AppServiceClient(dio: dio));

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(() =>
      RemoteDataSourceImpl(appServiceClient: instance<AppServiceClient>()));

  // repository

  instance.registerLazySingleton<Repository>(() =>
      RepositoryImpl(networkInfo: instance(), remoteDataSource: instance()));
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(
        () => LoginUseCase(repository: instance()));
    instance.registerFactory<LoginViewModel>(
        () => LoginViewModel(loginUseCase: instance()));
  }
}
