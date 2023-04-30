import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/app/constants.dart';
import '../response/responses.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseURL)
abstract class AppServiceClient {
  factory AppServiceClient({required Dio dio, String? baseURL}) =>
      _AppServiceClient(dio);

  @POST('/customer/login')
  Future<AuthenticationResponse> login(
      @Field('email') String email, @Field('password') String password);
}
