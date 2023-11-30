class RegisterModel {
  RegisterModel({
    required this.status,
    required this.message,
    required this.body,
  });
  late final int status;
  late final String message;
  late final Body body;

  RegisterModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    body = Body.fromJson(json['body']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['body'] = body.toJson();
    return _data;
  }
}

class Body {
  Body({
    required this.otp,
  });
  late final String otp;

  Body.fromJson(Map<String, dynamic> json){
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['otp'] = otp;
    return _data;
  }
}