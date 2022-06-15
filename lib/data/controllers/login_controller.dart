import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ubenwa_cart/data/local/local_storage.dart';
import 'package:ubenwa_cart/data/models/login_request.dart';
import 'package:ubenwa_cart/data/models/login_response.dart';
import 'package:ubenwa_cart/data/resource.dart';
import 'package:ubenwa_cart/data/services/auth_service.dart';
import 'package:ubenwa_cart/utils/constants.dart';

import '../local/storage_keys.dart';

class LoginController with ChangeNotifier {
  final LoginRequest _loginRequest = LoginRequest();
  final AuthService _authService = AuthService();
  late BehaviorSubject<Resource> _loginResourceStateController;
  Stream<Resource> get loginResourceState => _loginResourceStateController;

  LoginController() {
    _loginResourceStateController =
        BehaviorSubject<Resource>.seeded(Resource.success(null));
  }

  set setLoginEmail(String email) {
    _loginRequest.email = email;
  }

  set setLoginPassword(String password) {
    _loginRequest.password = password;
  }

  initiateUserLogin() {
    if (isEmpty(_loginRequest.email)) {
      _loginResourceStateController.sink
          .add(Resource.error(errorMessage: "Email field is empty"));
    } else if (isEmpty(_loginRequest.password)) {
      _loginResourceStateController.sink
          .add(Resource.error(errorMessage: "Password field is empty"));
    } else {
      _loginUser();
    }
  }

  _loginUser() async {
    _loginResourceStateController.sink.add(Resource.loading(null));
    try {
      var res = await _authService.loginUser(_loginRequest.toJson());
      var data = LoginResponse.fromJson(res);
      if (!isEmpty(data.token)) {
        LocalStorage()
            .writeData(key: StorageKeys.userToken, value: data.token!);
        _loginResourceStateController.sink.add(Resource.success(data));
      } else {
        _loginResourceStateController.sink
            .add(Resource.error(errorMessage: "An error occurred"));
      }
    } catch (ex) {
      _loginResourceStateController.sink
          .add(Resource.error(errorMessage: ex.toString()));
    }
  }
}
