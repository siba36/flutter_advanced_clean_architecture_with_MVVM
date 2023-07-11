import 'package:dio/dio.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/data/data_sources/local_data_source.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/domain/usecases/forgot_password_usecase.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/domain/usecases/register_usecase.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/domain/usecases/store_details_usecase.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/presentation/forget_password/view_model/forgot_password_view_model.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/presentation/store_details/view_model/store_details_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/data_sources/remote_data_source.dart';
import '../data/network/app_api.dart';
import '../data/network/dio_factory.dart';
import '../data/network/network_info.dart';
import '../data/repository_impl/repository_impl.dart';
import '../domain/repository/repository.dart';
import '../domain/usecases/home_usecase.dart';
import '../domain/usecases/login_usecase.dart';
import '../presentation/login/view_model/login_view_model.dart';
import '../presentation/main/pages/home/view_model/home_view_model.dart';
import '../presentation/register/view_model/register_view_model.dart';
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

  // data sources
  instance.registerLazySingleton<RemoteDataSource>(() =>
      RemoteDataSourceImpl(appServiceClient: instance<AppServiceClient>()));
  instance.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());

  // repository
  instance.registerLazySingleton<Repository>(() => RepositoryImpl(
      networkInfo: instance(),
      remoteDataSource: instance(),
      localDataSource: instance()));
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(
        () => LoginUseCase(repository: instance()));
    instance.registerFactory<LoginViewModel>(
        () => LoginViewModel(loginUseCase: instance()));
  }
}

initForgotPasswordModule() {
  if (!GetIt.I.isRegistered<ForgotPasswordUseCase>()) {
    instance.registerFactory<ForgotPasswordUseCase>(
        () => ForgotPasswordUseCase(repository: instance()));
    instance.registerFactory<ForgotPasswordViewModel>(
        () => ForgotPasswordViewModel(forgotPasswordUseCase: instance()));
  }
}

initRegisterModule() {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    instance.registerFactory<RegisterUseCase>(
        () => RegisterUseCase(repository: instance()));
    instance.registerFactory<RegisterViewModel>(
        () => RegisterViewModel(registerUseCase: instance()));
    instance.registerFactory<ImagePicker>(() => ImagePicker());
  }
}

initHomeModule() {
  if (!GetIt.I.isRegistered<HomeUseCase>()) {
    instance.registerFactory<HomeUseCase>(
        () => HomeUseCase(repository: instance()));
    instance.registerFactory<HomeViewModel>(
        () => HomeViewModel(homeUseCase: instance()));
  }
}

initStoreDetailsModule() {
  if (!GetIt.I.isRegistered<StoreDetailsUseCase>()) {
    instance.registerFactory<StoreDetailsUseCase>(
        () => StoreDetailsUseCase(repository: instance()));
    instance.registerFactory<StoreDetailsViewModel>(
        () => StoreDetailsViewModel(storeDetailsUseCase: instance()));
  }
}
