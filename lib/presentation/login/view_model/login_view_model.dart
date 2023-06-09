import 'dart:async';

import 'package:flutter_advanced_clean_architecture_with_mvvm/domain/usecases/login_usecase.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/presentation/base/base_view_model.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/presentation/common/freezed_data_classes.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/presentation/common/state_renderer/state_renederer.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInput, LoginViewModelOutput {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();

  final StreamController _areAllInputsValidController =
      StreamController<void>.broadcast();

  final StreamController isUserLoggedInSuccessfullyStreamController =
      StreamController<bool>();

  var loginObject = LoginObject("", "");
  final LoginUseCase loginUseCase;

  LoginViewModel({required this.loginUseCase});

  @override
  void dispose() {
    super.dispose();
    _userNameStreamController.close();
    _passwordStreamController.close();
    _areAllInputsValidController.close();
    isUserLoggedInSuccessfullyStreamController.close();
  }

  @override
  void start() {
    //view model should tell the view to show content state
    inputState.add(ContentState());
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
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    final result = await loginUseCase.execute(
      LoginUseCaseInput(
        username: loginObject.username,
        password: loginObject.password,
      ),
    );
    result.fold((failure) {
      inputState.add(ErrorState(
          stateRendererType: StateRendererType.popupErrorState,
          message: failure.message));
    }, (data) {
      inputState.add(ContentState());
      isUserLoggedInSuccessfullyStreamController.add(true);
    });
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

abstract class LoginViewModelInput {
  setUsername(String username);
  setPassword(String password);
  login();

  Sink get inputUsername;
  Sink get inputPassword;
  Sink get inputAreAllInputsValid;
}

abstract class LoginViewModelOutput {
  Stream<bool> get outIsUsernameValid;
  Stream<bool> get outIsPasswordValid;
  Stream<bool> get outAreAllInputsValid;
}
