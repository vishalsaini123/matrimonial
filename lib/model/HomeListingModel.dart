class HomeListingModel {
  HomeListingModel({
     this.status,
    this.message,
    this.data,
  });
  late final int? status;
  late final String? message;
  late final List<Data>? data;

  HomeListingModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['data'] = data?.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.image,
    required this.about,
    required this.age,
    required this.id,
    required this.name,
  });
  late List<String> image;
  late final String about;
  late final int age;
  late final int id;
  late final String name;

  Data.fromJson(Map<String, dynamic> json){
    image = List.castFrom<dynamic, String>(json['image']);
    about = json['about'];
    age = json['age'];
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['image']   = image;
    _data['about'] = about;
    _data['age'] = age;
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}