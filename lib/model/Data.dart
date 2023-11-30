class Data {
  Data({
      this.error,
      this.message, 
      this.registerd, 
      this.otp, 
      this.name, 
      this.profilepicture, 
      this.email, 
      this.address, 
      this.phoneNumber, 
      this.qualification, 
      this.gender, 
      this.age, 
      this.images, 
      this.preferences, 
      this.token,});

  Data.fromJson(dynamic json) {
    error = json['error'];
    message = json['message'];
    registerd = json['Registerd'];
    otp = json['otp'];
    name = json['name'];
    profilepicture = json['profilepicture'];
    email = json['email'];
    address = json['address'];
    phoneNumber = json['phone_number'];
    qualification = json['qualification'];
    gender = json['gender'];
    age = json['age'];
    images = json['images'];
    preferences = json['preferences'];
    token = json['token'];
  }
  int? error;
  String? message;
  int? registerd;
  String? otp;
  dynamic? name;
  dynamic? profilepicture;
  String? email;
  dynamic? address;
  String? phoneNumber;
  dynamic? qualification;
  String? gender;
  int? age;
  dynamic? images;
  dynamic? preferences;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = error;
    map['message'] = message;
    map['Registerd'] = registerd;
    map['otp'] = otp;
    map['name'] = name;
    map['profilepicture'] = profilepicture;
    map['email'] = email;
    map['address'] = address;
    map['phone_number'] = phoneNumber;
    map['qualification'] = qualification;
    map['gender'] = gender;
    map['age'] = age;
    map['images'] = images;
    map['preferences'] = preferences;
    map['token'] = token;
    return map;
  }

}