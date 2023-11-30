class RegisterVerifyOtpModel {
  RegisterVerifyOtpModel({
    required this.status,
    required this.data,
  });
  late final int status;
  late final Data data;

  RegisterVerifyOtpModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.error,
    required this.isVerified,
    required this.loggedIn,
    required this.message,
  });
  late final int error;
  late final int isVerified;
  late final int loggedIn;
  late final String message;

  Data.fromJson(Map<String, dynamic> json){
    error = json['error'];
    isVerified = json['isVerified'];
    loggedIn = json['loggedIn'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['error'] = error;
    _data['isVerified'] = isVerified;
    _data['loggedIn'] = loggedIn;
    _data['message'] = message;
    return _data;
  }
}