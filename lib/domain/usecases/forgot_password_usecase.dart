import 'package:dartz/dartz.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/data/network/Failure.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/domain/repository/repository.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/domain/usecases/base_usecase.dart';

class ForgotPasswordUseCase extends BaseUseCase<String, String> {
  Repository repository;

  ForgotPasswordUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> execute(String input) async {
    return await repository.forgotPassword(input);
  }
}
