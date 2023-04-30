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
