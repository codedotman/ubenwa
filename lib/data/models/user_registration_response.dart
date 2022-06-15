class UserRegistrationResponse {
  String? token;
  int? userId;
  UserInfo? userInfo;

  UserRegistrationResponse({this.token, this.userId, this.userInfo});

  UserRegistrationResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userId = json['user_id'];
    userInfo = json['user_info'] != null
        ? new UserInfo.fromJson(json['user_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['user_id'] = this.userId;
    if (this.userInfo != null) {
      data['user_info'] = this.userInfo!.toJson();
    }
    return data;
  }
}

class UserInfo {
  String? firstName;
  String? lastName;
  String? email;
  bool? userConsent;
  bool? isActiveListening;
  String? newborn;

  UserInfo(
      {this.firstName,
      this.lastName,
      this.email,
      this.userConsent,
      this.isActiveListening,
      this.newborn});

  UserInfo.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    userConsent = json['user_consent'];
    isActiveListening = json['is_active_listening'];
    newborn = json['newborn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['user_consent'] = this.userConsent;
    data['is_active_listening'] = this.isActiveListening;
    data['newborn'] = this.newborn;
    return data;
  }
}
