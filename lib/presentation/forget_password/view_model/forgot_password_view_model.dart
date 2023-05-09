import 'dart:async';

import 'package:flutter_advanced_clean_architecture_with_mvvm/domain/usecases/forgot_password_usecase.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/presentation/base/base_view_model.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/presentation/common/state_renderer/state_renederer.dart';

import '../../../app/functions.dart';
import '../../common/state_renderer/state_renderer_impl.dart';

class ForgotPasswordViewModel extends BaseViewModel
    with ForgotPasswordViewModelInputs, ForgotPasswordViewModelOutputs {
  final StreamController _emailStreamController =
      StreamController<String>.broadcast();

  final StreamController _areAllInputsValidController =
      StreamController<void>.broadcast();

  String email = "";

  ForgotPasswordUseCase forgotPasswordUseCase;

  ForgotPasswordViewModel({required this.forgotPasswordUseCase});

  @override
  void start() {
    //view model should tell the view to show content state
    inputState.add(ContentState());
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputAreAllInputsValid => _areAllInputsValidController.sink;

  @override
  forgotPassword() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    final result = await forgotPasswordUseCase.execute(email);
    result.fold((failure) {
      inputState.add(
        ErrorState(
          stateRendererType: StateRendererType.popupErrorState,
          message: failure.message,
        ),
      );
    }, (supportMessage) {
      inputState.add(ContentState());
      // inputState.add(ErrorState(
      //     stateRendererType: StateRendererType.popupErrorState,
      //     message: "success"));
    });
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    this.email = email;
    inputAreAllInputsValid.add(null);
  }

  @override
  void dispose() {
    super.dispose();
    _emailStreamController.close();
    _areAllInputsValidController.close();
  }

  bool _areAllInputsValid() {
    return isEmailValid(email);
  }

  @override
  Stream<bool> get outputIsEmailValid =>
      _emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<bool> get outputAreAllInputsValid =>
      _areAllInputsValidController.stream.map((_) => _areAllInputsValid());
}

abstract class ForgotPasswordViewModelInputs {
  setEmail(String email);
  forgotPassword();

  Sink get inputEmail;
  Sink get inputAreAllInputsValid;
}

abstract class ForgotPasswordViewModelOutputs {
  Stream<bool> get outputIsEmailValid;
  Stream<bool> get outputAreAllInputsValid;
}
