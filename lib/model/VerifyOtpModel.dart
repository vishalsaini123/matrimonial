class VerifyOtpModel {
  VerifyOtpModel({
    required this.status,
    required this.message,
    required this.body,
  });
  late final int status;
  late final String message;
  late final Body body;

  VerifyOtpModel.fromJson(Map<String, dynamic> json){
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
    required this.error,
    required this.loggedIn,
  });
  late final int error;
  late final int loggedIn;

  Body.fromJson(Map<String, dynamic> json){
    error = json['error'];
    loggedIn = json['loggedIn'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['error'] = error;
    _data['loggedIn'] = loggedIn;
    return _data;
  }
}