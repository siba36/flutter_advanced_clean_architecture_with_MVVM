import 'package:freezed_annotation/freezed_annotation.dart';

part 'freezed_data_classes.freezed.dart';

@freezed
class LoginObject with _$LoginObject {
  factory LoginObject(String username, String password) = _LoginObject;
}

@freezed
class RegisterObject with _$RegisterObject {
  factory RegisterObject(
      String userName,
      String countryCode,
      String mobileNumber,
      String email,
      String password,
      String profilePicture) = _RegisterObject;
}
