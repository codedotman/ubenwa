import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ubenwa_cart/data/local/local_storage.dart';
import 'package:ubenwa_cart/data/models/user_registration_request.dart';
import 'package:ubenwa_cart/data/resource.dart';
import 'package:ubenwa_cart/data/services/auth_service.dart';
import 'package:ubenwa_cart/utils/constants.dart';

import '../local/storage_keys.dart';
import '../models/user_registration_response.dart';

class RegistrationController with ChangeNotifier {
  final UserRegistrationRequest _userRegistrationRequest =
      UserRegistrationRequest();

  final AuthService _authService = AuthService();
  late BehaviorSubject<Resource> _userRegistrationResourceStateController;
  Stream<Resource> get userRegistrationResourceState =>
      _userRegistrationResourceStateController.stream;

  RegistrationController() {
    _userRegistrationResourceStateController =
        BehaviorSubject<Resource>.seeded(Resource.success(null));
  }
  set setRegistrationEmail(String email) {
    _userRegistrationRequest.email = email;
  }

  set setRegistrationPassword(String password) {
    _userRegistrationRequest.password = password;
  }

  set setRegistrationFirstName(String firstName) {
    _userRegistrationRequest.firstName = firstName;
  }

  set setRegistrationLastName(String lastName) {
    _userRegistrationRequest.lastName = lastName;
  }

  initiateUserRegistration() {
    if (isEmpty(_userRegistrationRequest.firstName)) {
      _userRegistrationResourceStateController.sink
          .add(Resource.error(errorMessage: "First name field is empty"));
    } else if (isEmpty(_userRegistrationRequest.lastName)) {
      _userRegistrationResourceStateController.sink
          .add(Resource.error(errorMessage: "Last name field is empty"));
    } else if (isEmpty(_userRegistrationRequest.email)) {
      _userRegistrationResourceStateController.sink
          .add(Resource.error(errorMessage: "Email field is empty"));
    } else if (isEmpty(_userRegistrationRequest.password) ||
        !(_userRegistrationRequest.password?.contains(RegExp(r"(.,)")) ??
            true)) {
      _userRegistrationResourceStateController.sink
          .add(Resource.error(errorMessage: "Password field is empty"));
    } else {
      _registerUser();
    }
  }

  _registerUser() async {
    _userRegistrationResourceStateController.sink.add(Resource.loading(null));
    try {
      var res =
          await _authService.registerUser(_userRegistrationRequest.toJson());
      var data = UserRegistrationResponse.fromJson(res);
      if (!isEmpty(data.token)) {
        LocalStorage()
            .writeData(key: StorageKeys.userToken, value: data.token!);
        _userRegistrationResourceStateController.sink
            .add(Resource.success(data));
      } else {
        _userRegistrationResourceStateController.sink
            .add(Resource.error(errorMessage: "An error occurred"));
      }
    } catch (ex) {
      _userRegistrationResourceStateController.sink
          .add(Resource.error(errorMessage: ex.toString()));
    }
  }
}
