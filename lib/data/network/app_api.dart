import 'package:dio/dio.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/app/constants.dart';
import 'package:retrofit/retrofit.dart';

import '../response/responses.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseURL)
abstract class AppServiceClient {
  factory AppServiceClient({required Dio dio, String? baseURL}) =>
      _AppServiceClient(dio);

  @POST('/customer/login')
  Future<AuthenticationResponse> login(
      @Field('email') String email, @Field('password') String password);

  @POST('/customer/forgotPassword')
  Future<ForgotPasswordResponse> forgotPassword(@Field('email') String email);

  @POST('/customer/register')
  Future<AuthenticationResponse> register(
    @Field('user_name') String userName,
    @Field('country_code') String countryCode,
    @Field('mobile_number') String mobileNumber,
    @Field('email') String email,
    @Field('password') String password,
    @Field('profile_picture') String profilePicture,
  );

  @GET('/home')
  Future<HomeResponse> getHomeData();
}
