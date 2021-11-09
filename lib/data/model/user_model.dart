class User {
  final String uid;

  User({required this.uid});
}

class UserModel {
  late String id;
  String? name;
  String? email;
  String? phoneno;
  String? address;
  String? type;
  UserModel(
      {required this.id,
      this.name,
      this.email,
      this.phoneno,
      this.address,
      this.type});

  UserModel.initial()
      : id = '0',
        name = '',
        email = '',
        phoneno = '123456',
        address = '',
        type = '';

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneno = json['phoneno'];
    address = json['address'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.email;
    data['phoneno'] = this.phoneno;
    data['address'] = this.address;
    data['type'] = this.type;
    return data;
  }
}
