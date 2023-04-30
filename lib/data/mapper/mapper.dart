import 'package:flutter_advanced_clean_architecture_with_mvvm/app/constants.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/data/response/responses.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/app/extensions.dart';

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
