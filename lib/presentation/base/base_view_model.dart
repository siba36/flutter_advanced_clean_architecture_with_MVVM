import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../common/state_renderer/state_renderer_impl.dart';

abstract class BaseViewModel with BaseViewModelInputs, BaseViewModelOutputs {
  //shared variables and functions that will be used through any view model
  final StreamController _inputStateController = BehaviorSubject<FlowState>();

  @override
  Sink get inputState => _inputStateController.sink;

  @override
  Stream<FlowState> get outputState =>
      _inputStateController.stream.map((flowState) => flowState);

  @override
  void dispose() {
    _inputStateController.close();
  }
}

abstract class BaseViewModelInputs {
  void start(); //start view model job

  void dispose(); //will be called when view model dies

  Sink get inputState;
}

abstract class BaseViewModelOutputs {
  Stream<FlowState> get outputState;
}
