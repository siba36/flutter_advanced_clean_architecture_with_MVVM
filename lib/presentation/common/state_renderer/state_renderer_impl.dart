import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/app/constants.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/presentation/common/state_renderer/state_renederer.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/presentation/resources/strings_manager.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();
  String getMessage();
}

//loading state (popup,full screen)
class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  LoadingState(
      {required this.stateRendererType, this.message = AppStrings.loading});

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  ErrorState({required this.stateRendererType, required this.message});

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

class ContentState extends FlowState {
  @override
  String getMessage() => Constants.empty;

  @override
  StateRendererType getStateRendererType() => StateRendererType.contentState;
}

class EmptyState extends FlowState {
  String message;

  EmptyState({required this.message});

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.fullScreenEmptyState;
}

class SuccessState extends FlowState {
  String message;
  SuccessState({required this.message});

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.popupSuccessState;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryActionFunction) {
    switch (runtimeType) {
      case LoadingState:
        if (getStateRendererType() == StateRendererType.popupLoadingState) {
          showPopup(context, getMessage(), getStateRendererType());
          return contentScreenWidget;
        } else {
          return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              retryActionFunction: retryActionFunction);
        }

      case ErrorState:
        dismissDialog(context);
        if (getStateRendererType() == StateRendererType.popupErrorState) {
          showPopup(context, getMessage(), getStateRendererType());
          return contentScreenWidget;
        } else {
          return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              retryActionFunction: retryActionFunction);
        }

      case ContentState:
        dismissDialog(context);
        return contentScreenWidget;

      case EmptyState:
        return StateRenderer(
            stateRendererType: getStateRendererType(),
            message: getMessage(),
            retryActionFunction: () {});

      case SuccessState:
        dismissDialog(context);
        showPopup(context, getMessage(), getStateRendererType(),
            title: AppStrings.success);
        return contentScreenWidget;
      default:
        dismissDialog(context);
        return contentScreenWidget;
    }
  }

  bool isCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)!.isCurrent != true;

  void dismissDialog(BuildContext context) {
    if (isCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  void showPopup(
      BuildContext context, String message, StateRendererType stateRendererType,
      {String title = Constants.empty}) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => showDialog(
        context: context,
        builder: (context) => StateRenderer(
          stateRendererType: stateRendererType,
          title: title,
          message: message,
          retryActionFunction: () {},
        ),
      ),
    );
  }
}
