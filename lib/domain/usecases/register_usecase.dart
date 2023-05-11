import 'package:dartz/dartz.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/data/network/Failure.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/data/network/requests.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/domain/model/models.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/domain/repository/repository.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/domain/usecases/base_usecase.dart';

class RegisterUseCase
    extends BaseUseCase<RegisterUseCaseInput, Authentication> {
  Repository repository;

  RegisterUseCase({required this.repository});

  @override
  Future<Either<Failure, Authentication>> execute(
      RegisterUseCaseInput input) async {
    return await repository.register(RegisterRequest(
        userName: input.userName,
        countryCode: input.countryCode,
        mobileNumber: input.mobileNumber,
        email: input.email,
        password: input.password,
        profilePicture: input.profilePicture));
  }
}

class RegisterUseCaseInput {
  String userName;
  String countryCode;
  String mobileNumber;
  String email;
  String password;
  String profilePicture;

  RegisterUseCaseInput(
      {required this.userName,
      required this.countryCode,
      required this.mobileNumber,
      required this.email,
      required this.password,
      required this.profilePicture});
}
