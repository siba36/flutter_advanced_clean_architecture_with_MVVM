import 'package:dio/dio.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/app/app_preferences.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/data/data_sources/remote_data_source.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/data/network/app_api.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/data/network/dio_factory.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/data/network/network_info.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/data/repository_impl/repository_impl.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/domain/repository/repository.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/domain/usecases/login_usecase.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/presentation/login/view_model/login_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  //all generic dependencies

  //shared preference instance
  final sharedPreference = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPreference);

  //app preference
  instance.registerLazySingleton<AppPreferences>(
      () => AppPreferences(sharedPreferences: instance()));

  //network info
  instance.registerLazySingleton<NetworkInfo>(() =>
      NetworkInfoImpl(internetConnectionChecker: InternetConnectionChecker()));

  //dio factory
  instance.registerLazySingleton<DioFactory>(
      () => DioFactory(appPreferences: instance()));
  Dio dio = await instance<DioFactory>().getDio();

  //app service client
  instance.registerLazySingleton<AppServiceClient>(
      () => AppServiceClient(dio: dio));

  //remote data source
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(appServiceClient: instance()));

  //repository
  instance.registerLazySingleton<Repository>(() =>
      RepositoryImpl(networkInfo: instance(), remoteDataSource: instance()));
}

void initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(
        () => LoginUseCase(repository: instance()));
    instance.registerFactory<LoginViewModel>(
        () => LoginViewModel(loginUseCase: instance()));
  }
}
