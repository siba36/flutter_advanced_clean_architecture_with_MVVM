import 'package:dartz/dartz.dart';

import 'package:flutter_advanced_clean_architecture_with_mvvm/data/network/Failure.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/data/network/requests.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/domain/repository/repository.dart';

import '../model/models.dart';
import 'base_usecase.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authentication> {
  final Repository repository;

  const LoginUseCase({required this.repository});

  @override
  Future<Either<Failure, Authentication>> execute(
      LoginUseCaseInput input) async {
    return await repository
        .login(LoginRequest(email: input.username, password: input.password));
  }
}

class LoginUseCaseInput {
  final String username;
  final String password;

  const LoginUseCaseInput({required this.username, required this.password});
}
