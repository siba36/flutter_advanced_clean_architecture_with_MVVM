import 'dart:async';

import 'package:flutter_advanced_clean_architecture_with_mvvm/domain/usecases/login_usecase.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/presentation/base/base_view_model.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/presentation/common/freezed_data_classes.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();

  final StreamController _areAllInputsValidController =
      StreamController<void>.broadcast();

  var loginObject = LoginObject("", "");
  // final LoginUseCase loginUseCase;

  LoginViewModel();
  // LoginViewModel({required this.loginUseCase});

  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
    _areAllInputsValidController.close();
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  setUsername(String username) {
    inputUsername.add(username);
    loginObject = loginObject.copyWith(username: username);
    inputAreAllInputsValid.add(null);
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    inputAreAllInputsValid.add(null);
  }

  @override
  Sink get inputUsername => _userNameStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputAreAllInputsValid => _areAllInputsValidController.sink;

  @override
  login() async {
    // final result = await loginUseCase.execute(
    //   LoginUseCaseInput(
    //     username: loginObject.username,
    //     password: loginObject.password,
    //   ),
    // );
    // result.fold((failure) {
    //   print(failure.message);
    // }, (data) {
    //   print(data.customer!.name);
    // });
  }

  @override
  Stream<bool> get outIsUsernameValid => _userNameStreamController.stream
      .map((username) => _isUsernameValid(username));

  @override
  Stream<bool> get outIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outAreAllInputsValid =>
      _areAllInputsValidController.stream.map((_) => _areAllInputsValid());

  bool _isUsernameValid(String username) {
    return username.isNotEmpty;
  }

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _areAllInputsValid() {
    return _isUsernameValid(loginObject.username) &&
        _isPasswordValid(loginObject.password);
  }
}

abstract class LoginViewModelInputs {
  setUsername(String username);
  setPassword(String password);
  login();

  Sink get inputUsername;
  Sink get inputPassword;
  Sink get inputAreAllInputsValid;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outIsUsernameValid;
  Stream<bool> get outIsPasswordValid;
  Stream<bool> get outAreAllInputsValid;
}
