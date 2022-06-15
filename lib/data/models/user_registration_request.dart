class UserRegistrationRequest {
  String? firstName;
  String? lastName;
  String? email;
  String? password;

  UserRegistrationRequest(
      {this.firstName, this.lastName, this.email, this.password});

  UserRegistrationRequest.fromJson(Map<String, dynamic> json) {
    firstName = json['first_Name'];
    lastName = json['last_Name'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_Name'] = this.firstName;
    data['last_Name'] = this.lastName;
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}
