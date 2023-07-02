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
  final StreamController _homeDataStreamController =
      BehaviorSubject<HomeViewObject>();

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
      inputHomeData.add(HomeViewObject(
        banners: homeObject.data.banners,
        stores: homeObject.data.stores,
        services: homeObject.data.services,
      ));
    });
  }

  @override
  void dispose() {
    _homeDataStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputHomeData => _homeDataStreamController.sink;

  @override
  Stream<HomeViewObject> get outputHomeData =>
      _homeDataStreamController.stream.map((homeData) => homeData);
}

abstract class HomeViewModelInput {
  Sink get inputHomeData;
}

abstract class HomeViewModelOutput {
  Stream<HomeViewObject> get outputHomeData;
}

class HomeViewObject {
  List<BannerAd> banners;
  List<Store> stores;
  List<Service> services;

  HomeViewObject(
      {required this.banners, required this.stores, required this.services});
}
