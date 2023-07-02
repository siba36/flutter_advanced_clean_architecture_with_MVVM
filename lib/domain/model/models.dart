class SliderObject {
  final String title;
  final String subtitle;
  final String imagePath;

  const SliderObject({
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });
}

class SliderViewObject {
  final SliderObject sliderObject;
  final int currentIndex;
  final int numberOfSlides;

  const SliderViewObject(
      {required this.sliderObject,
      required this.currentIndex,
      required this.numberOfSlides});
}

class Customer {
  String id;
  String name;
  int numberOfNotifications;

  Customer(
      {required this.id,
      required this.name,
      required this.numberOfNotifications});
}

class Contacts {
  String phone;
  String email;
  String link;

  Contacts({required this.phone, required this.email, required this.link});
}

class Authentication {
  Customer? customer;
  Contacts? contacts;

  Authentication({required this.customer, required this.contacts});
}

class Service {
  int id;
  String title;
  String image;

  Service({required this.id, required this.title, required this.image});
}

class BannerAd {
  int id;
  String title;
  String image;
  String link;

  BannerAd(
      {required this.id,
      required this.title,
      required this.image,
      required this.link});
}

class Store {
  int id;
  String title;
  String image;

  Store({required this.id, required this.title, required this.image});
}

class HomeData {
  List<Service> services;
  List<BannerAd> banners;
  List<Store> stores;

  HomeData(
      {required this.services, required this.banners, required this.stores});
}

class HomeObject {
  HomeData? data;

  HomeObject({required this.data});
}
