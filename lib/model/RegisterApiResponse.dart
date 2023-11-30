class RegisterApiResponse {
  RegisterApiResponse({
     this.status,
     this.message,
     this.data,
  });
    int? status;
    String? message;
    Data? data;

  RegisterApiResponse.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['data'] = data?.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.error,
    required this.message,
    required this.Registerd,
    required this.token,
    required this.otp,
  });
  late final int error;
  late final String message;
  late final int Registerd;
  late final String token;
  late final String otp;

  Data.fromJson(Map<String, dynamic> json){
    error = json['error'];
    message = json['message'];
    Registerd = json['Registerd'];
    token = json['token'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['error'] = error;
    _data['message'] = message;
    _data['Registerd'] = Registerd;
    _data['token'] = token;
    _data['otp'] = otp;
    return _data;
  }
}