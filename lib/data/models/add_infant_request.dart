class AddInfantRequest {
  Data? data;

  AddInfantRequest({this.data});

  AddInfantRequest.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? type;
  InfantAttributes? attributes;

  Data({this.type, this.attributes});

  Data.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    attributes = json['attributes'] != null
        ? new InfantAttributes.fromJson(json['attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.toJson();
    }
    return data;
  }
}

class InfantAttributes {
  String? name;
  String? gestation;
  String? gender;

  InfantAttributes({this.name, this.gestation, this.gender});

  InfantAttributes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    gestation = json['gestation'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['gestation'] = this.gestation;
    data['gender'] = this.gender;
    return data;
  }
}
