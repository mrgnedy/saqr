class ProfoileModel {
  String msg;
  Data data;

  ProfoileModel({this.msg, this.data});

  ProfoileModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int id;
  String name;
  String phone;
  int code;
  String apiToken;
  String imageId;
  String imageProfile;
  int isProvider;
  int active;
  String deviceToken;

  Data(
      {this.id,
      this.name,
      this.phone,
      this.code,
      this.apiToken,
      this.imageId,
      this.imageProfile,
      this.isProvider,
      this.active,
      this.deviceToken});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    code = json['code'];
    apiToken = json['api_token'];
    imageId = json['imageId'];
    imageProfile = json['imageProfile'];
    isProvider = json['is_provider'];
    active = json['active'];
    deviceToken = json['device_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['code'] = this.code;
    data['api_token'] = this.apiToken;
    data['imageId'] = this.imageId;
    data['imageProfile'] = this.imageProfile;
    data['is_provider'] = this.isProvider;
    data['active'] = this.active;
    data['device_token'] = this.deviceToken;
    return data;
  }
}