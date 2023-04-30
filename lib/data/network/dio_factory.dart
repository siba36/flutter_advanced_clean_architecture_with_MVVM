import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/app/app_preferences.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../app/constants.dart';

const applicationJSON = 'application/json';
const contentType = 'content-type';
const accept = 'accept';
const authorization = 'authorization';
const defaultLanguage = 'language';

class DioFactory {
  final AppPreferences appPreferences;

  const DioFactory({required this.appPreferences});

  Future<Dio> getDio() async {
    Dio dio = Dio();

    String language = await appPreferences.getAppLanguage();

    Map<String, String> headers = {
      contentType: applicationJSON,
      accept: applicationJSON,
      authorization: Constants.token,
      defaultLanguage: language,
    };
    dio.options = BaseOptions(
      baseUrl: Constants.baseURL,
      headers: headers,
      sendTimeout: const Duration(milliseconds: Constants.APITimeout),
      receiveTimeout: const Duration(milliseconds: Constants.APITimeout),
    );

    if (!kReleaseMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
        ),
      );
    }
    return dio;
  }
}
