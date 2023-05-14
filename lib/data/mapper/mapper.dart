import 'package:flutter_advanced_clean_architecture_with_mvvm/app/constants.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/app/extensions.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/data/response/responses.dart';

import '../../domain/model/models.dart';

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
        id: this?.id.orEmpty() ?? Constants.empty,
        name: this?.name.orEmpty() ?? Constants.empty,
        numberOfNotifications:
            this?.numberOfNotifications.orZero() ?? Constants.zero);
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(
        phone: this?.phone.orEmpty() ?? Constants.empty,
        email: this?.email.orEmpty() ?? Constants.empty,
        link: this?.link.orEmpty() ?? Constants.empty);
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
        customer: this?.customer.toDomain(),
        contacts: this?.contacts.toDomain());
  }
}

extension ForgotPasswordResponseMapper on ForgotPasswordResponse? {
  String toDomain() {
    return this?.support?.orEmpty() ?? Constants.empty;
  }
}

extension ServicesResponseMapper on ServicesResponse? {
  Service toDomain() {
    return Service(
        id: this?.id.orZero() ?? Constants.zero,
        title: this?.title ?? Constants.empty,
        image: this?.image ?? Constants.empty);
  }
}

extension StoresResponseMapper on StoresResponse? {
  Store toDomain() {
    return Store(
        id: this?.id.orZero() ?? Constants.zero,
        title: this?.title ?? Constants.empty,
        image: this?.image ?? Constants.empty);
  }
}

extension BannersResponseMapper on BannersResponse? {
  BannerAd toDomain() {
    return BannerAd(
        id: this?.id.orZero() ?? Constants.zero,
        title: this?.title ?? Constants.empty,
        image: this?.image ?? Constants.empty,
        link: this?.link.orEmpty() ?? Constants.empty);
  }
}

extension HomeResponseMapper on HomeResponse? {
  HomeObject toDomain() {
    List<Service> services = (this
                ?.data
                ?.services
                ?.map((serviceResponse) => serviceResponse.toDomain()) ??
            const Iterable.empty())
        .cast<Service>()
        .toList();

    List<Store> stores = (this
                ?.data
                ?.services
                ?.map((storeResponse) => storeResponse.toDomain()) ??
            const Iterable.empty())
        .cast<Store>()
        .toList();

    List<BannerAd> banners = (this
                ?.data
                ?.services
                ?.map((bannerResponse) => bannerResponse.toDomain()) ??
            const Iterable.empty())
        .cast<BannerAd>()
        .toList();

    return HomeObject(
        data: HomeData(services: services, banners: banners, stores: stores));
  }
}
