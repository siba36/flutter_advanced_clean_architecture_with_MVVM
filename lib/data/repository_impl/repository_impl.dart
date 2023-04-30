import 'package:dartz/dartz.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/data/mapper/mapper.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/data/network/Failure.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/data/network/error_handler.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/data/network/network_info.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/data/network/requests.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/domain/model/models.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/domain/repository/repository.dart';

import '../data_sources/remote_data_source.dart';

class RepositoryImpl implements Repository {
  NetworkInfo networkInfo;
  RemoteDataSource remoteDataSource;

  RepositoryImpl({required this.networkInfo, required this.remoteDataSource});

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.login(loginRequest);

        if (response.status == APIInternalStatus.success) {
          return right(response.toDomain());
        } else {
          return left(Failure(
              statusCode: APIInternalStatus.failure,
              message: response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return left(ErrorHandler.handler(error).failure);
      }
    } else {
      return left(DataSource.noInternetConnection.getFailure());
    }
  }
}
