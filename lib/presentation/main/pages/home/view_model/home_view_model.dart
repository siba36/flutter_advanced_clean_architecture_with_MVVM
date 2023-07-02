import 'dart:async';
import 'dart:ffi';

import 'package:flutter_advanced_clean_architecture_with_mvvm/domain/usecases/home_usecase.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/presentation/base/base_view_model.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../domain/model/models.dart';
import '../../../../common/state_renderer/state_renederer.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInput, HomeViewModelOutput {
  final StreamController _servicesStreamController =
      BehaviorSubject<List<Service>>();
  final StreamController _bannersStreamController =
      BehaviorSubject<List<BannerAd>>();
  final StreamController _storesStreamController =
      BehaviorSubject<List<Store>>();

  final HomeUseCase homeUseCase;

  HomeViewModel({required this.homeUseCase});

  @override
  void start() {
    _getHomeData();
  }

  _getHomeData() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    final result = await homeUseCase.execute(Void);
    result.fold(
        (failure) => inputState.add(
              ErrorState(
                stateRendererType: StateRendererType.fullScreenErrorState,
                message: failure.message,
              ),
            ), (homeObject) {
      inputState.add(ContentState());
      inputService.add(homeObject.data?.services);
      inputBanners.add(homeObject.data?.banners);
      inputStores.add(homeObject.data?.stores);
    });
  }

  @override
  void dispose() {
    _servicesStreamController.close();
    _bannersStreamController.close();
    _storesStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputBanners => _bannersStreamController.sink;

  @override
  Sink get inputService => _servicesStreamController.sink;

  @override
  Sink get inputStores => _storesStreamController.sink;

  @override
  Stream<List<BannerAd>> get outputBanners =>
      _bannersStreamController.stream.map((banners) => banners);

  @override
  Stream<List<Service>> get outputServices =>
      _servicesStreamController.stream.map((services) => services);

  @override
  Stream<List<Store>> get outputStores =>
      _storesStreamController.stream.map((stores) => stores);
}

abstract class HomeViewModelInput {
  Sink get inputService;
  Sink get inputBanners;
  Sink get inputStores;
}

abstract class HomeViewModelOutput {
  Stream<List<Service>> get outputServices;
  Stream<List<BannerAd>> get outputBanners;
  Stream<List<Store>> get outputStores;
}
