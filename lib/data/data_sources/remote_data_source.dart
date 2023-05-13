import 'package:flutter_advanced_clean_architecture_with_mvvm/data/network/app_api.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/data/network/requests.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/data/response/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  Future<AuthenticationResponse> register(RegisterRequest registerRequest);
  Future<ForgotPasswordResponse> forgotPassword(String email);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  AppServiceClient appServiceClient;

  RemoteDataSourceImpl({required this.appServiceClient});

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await appServiceClient.login(
        loginRequest.email, loginRequest.password);
  }

  @override
  Future<ForgotPasswordResponse> forgotPassword(String email) async {
    return await appServiceClient.forgotPassword(email);
  }

  @override
  Future<AuthenticationResponse> register(
      RegisterRequest registerRequest) async {
    return await appServiceClient.register(
        registerRequest.userName,
        registerRequest.countryCode,
        registerRequest.mobileNumber,
        registerRequest.email,
        registerRequest.password,
        ""); //registerRequest.profilePicture); //because the mock API takes an empty image
  }
}
