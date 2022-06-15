class InfantsResponse {
  List<InfantDataList>? data;
  Meta? meta;
  Links? links;

  InfantsResponse({this.data, this.meta, this.links});

  InfantsResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <InfantDataList>[];
      json['data'].forEach((v) {
        data!.add(new InfantDataList.fromJson(v));
      });
    }
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    if (this.links != null) {
      data['links'] = this.links!.toJson();
    }
    return data;
  }
}

class InfantDataList {
  String? id;
  String? type;
  Links? links;
  Attributes? attributes;

  InfantDataList({this.id, this.type, this.links, this.attributes});

  InfantDataList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
    attributes = json['attributes'] != null
        ? new Attributes.fromJson(json['attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    if (this.links != null) {
      data['links'] = this.links!.toJson();
    }
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.toJson();
    }
    return data;
  }
}

class Links {
  String? self;

  Links({this.self});

  Links.fromJson(Map<String, dynamic> json) {
    self = json['self'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['self'] = this.self;
    return data;
  }
}

class Attributes {
  String? gender;
  String? gestation;
  Null? firstCryPushDate;
  String? name;
  int? userId;
  String? createdAt;
  String? updatedAt;

  Attributes(
      {this.gender,
      this.gestation,
      this.firstCryPushDate,
      this.name,
      this.userId,
      this.createdAt,
      this.updatedAt});

  Attributes.fromJson(Map<String, dynamic> json) {
    gender = json['gender'];
    gestation = json['gestation'];
    firstCryPushDate = json['first_cry_push_date'];
    name = json['name'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gender'] = this.gender;
    data['gestation'] = this.gestation;
    data['first_cry_push_date'] = this.firstCryPushDate;
    data['name'] = this.name;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Meta {
  int? recordCount;

  Meta({this.recordCount});

  Meta.fromJson(Map<String, dynamic> json) {
    recordCount = json['record_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['record_count'] = this.recordCount;
    return data;
  }
}

// class Links {
//   String? first;
//   String? last;
//
//   Links({this.first, this.last});
//
//   Links.fromJson(Map<String, dynamic> json) {
//     first = json['first'];
//     last = json['last'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['first'] = this.first;
//     data['last'] = this.last;
//     return data;
//   }
// }
