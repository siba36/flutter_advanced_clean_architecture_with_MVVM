import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../presentation/resources/strings_manager.dart';
import 'Failure.dart';

enum DataSource {
  success,
  noContent,
  badRequest,
  forbidden,
  unauthorized,
  notFound,
  internalServerError,
  connectTimeout,
  cancel,
  receiveTimeout,
  sendTimeout,
  cacheError,
  noInternetConnection,
  DEFAULT,

  connectionError,
  badResponse,
  badCertificate
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.success:
        return Failure(
            message: ResponseMessage.success.tr(),
            statusCode: ResponseCode.success);
      case DataSource.noContent:
        return Failure(
            message: ResponseMessage.noContent.tr(),
            statusCode: ResponseCode.noContent);
      case DataSource.badRequest:
        return Failure(
            message: ResponseMessage.badRequest.tr(),
            statusCode: ResponseCode.badRequest);
      case DataSource.forbidden:
        return Failure(
            message: ResponseMessage.forbidden.tr(),
            statusCode: ResponseCode.forbidden);
      case DataSource.unauthorized:
        return Failure(
            message: ResponseMessage.unauthorized.tr(),
            statusCode: ResponseCode.unauthorized);
      case DataSource.notFound:
        return Failure(
            message: ResponseMessage.notFound.tr(),
            statusCode: ResponseCode.notFound);
      case DataSource.internalServerError:
        return Failure(
            message: ResponseMessage.internalServerError.tr(),
            statusCode: ResponseCode.internalServerError);
      case DataSource.connectTimeout:
        return Failure(
            message: ResponseMessage.connectTimeout.tr(),
            statusCode: ResponseCode.connectTimeout);
      case DataSource.cancel:
        return Failure(
            message: ResponseMessage.cancel.tr(),
            statusCode: ResponseCode.cancel);
      case DataSource.receiveTimeout:
        return Failure(
            message: ResponseMessage.receiveTimeout.tr(),
            statusCode: ResponseCode.receiveTimeout);
      case DataSource.sendTimeout:
        return Failure(
            message: ResponseMessage.sendTimeout.tr(),
            statusCode: ResponseCode.sendTimeout);
      case DataSource.cacheError:
        return Failure(
            message: ResponseMessage.cacheError.tr(),
            statusCode: ResponseCode.cacheError);
      case DataSource.noInternetConnection:
        return Failure(
            message: ResponseMessage.noInternetConnection.tr(),
            statusCode: ResponseCode.noInternetConnection);
      case DataSource.DEFAULT:
        return Failure(
            message: ResponseMessage.DEFAULT.tr(),
            statusCode: ResponseCode.DEFAULT);

      case DataSource.connectionError:
        return Failure(
            message: ResponseMessage.connectionError.tr(),
            statusCode: ResponseCode.connectionError);
      case DataSource.badResponse:
        return Failure(
            message: ResponseMessage.badResponse.tr(),
            statusCode: ResponseCode.badResponse);
      case DataSource.badCertificate:
        return Failure(
            message: ResponseMessage.badCertificate.tr(),
            statusCode: ResponseCode.badCertificate);
    }
  }
}

class ResponseCode {
  static const int success = 200; //success with data
  static const int noContent = 201; //success with no data (no content)
  static const int badRequest = 400; //failure API rejected request
  static const int forbidden = 401; //failure user is not authorized
  static const int unauthorized = 403; //failure API rejected request
  static const int notFound = 404; // failure
  static const int internalServerError = 500; // failure crash in server

  //local status codes
  static const int connectTimeout = -1;
  static const int cancel = -2;
  static const int receiveTimeout = -3;
  static const int sendTimeout = -4;
  static const int cacheError = -5;
  static const int noInternetConnection = -6;
  static const int DEFAULT = -7;

  static const int connectionError = -8;
  static const int badResponse = -9;
  static const int badCertificate = -10;
}

class ResponseMessage {
  static const String success = AppStrings.success;
  static const String noContent = AppStrings.noContent;
  static const String badRequest = AppStrings.badRequest;
  static const String forbidden = AppStrings.forbidden;
  static const String unauthorized = AppStrings.unauthorized;
  static const String notFound = AppStrings.notFound;
  static const String internalServerError = AppStrings.internalServerError;

  //local status error messages
  static const String connectTimeout = AppStrings.connectTimeout;
  static const String cancel = AppStrings.cancel;
  static const String receiveTimeout = AppStrings.receiveTimeout;
  static const String sendTimeout = AppStrings.sendTimeout;
  static const String cacheError = AppStrings.cacheError;
  static const String noInternetConnection = AppStrings.noInternetConnection;
  static const String DEFAULT = AppStrings.DEFAULT;

  static const String connectionError = AppStrings.connectionError;
  static const String badResponse = AppStrings.badResponse;
  static const String badCertificate = AppStrings.badCertificate;
}

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handler(dynamic error) {
    if (error is DioError) {
      failure = _handleError(error);
    } else {
      failure = DataSource.DEFAULT.getFailure();
    }
  }

  Failure _handleError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.connectionTimeout:
        return DataSource.connectTimeout.getFailure();
      case DioErrorType.connectionError:
        return DataSource.connectionError.getFailure();
      case DioErrorType.receiveTimeout:
        return DataSource.receiveTimeout.getFailure();
      case DioErrorType.sendTimeout:
        return DataSource.sendTimeout.getFailure();
      case DioErrorType.badResponse:
        return DataSource.badResponse.getFailure();
      case DioErrorType.cancel:
        return DataSource.cancel.getFailure();
      case DioErrorType.badCertificate:
        return DataSource.badCertificate.getFailure();
      case DioErrorType.unknown:
        if (dioError.response != null &&
            dioError.response!.statusCode != null &&
            dioError.response!.statusMessage != null) {
          return Failure(
              statusCode: dioError.response!.statusCode!,
              message: dioError.response!.statusMessage!);
        } else {
          return DataSource.DEFAULT.getFailure();
        }
    }
  }
}

class APIInternalStatus {
  static const int success = 0;
  static const int failure = 1;
}
