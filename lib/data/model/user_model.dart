String userTable = 'user';

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

  String get getId => id.toString();

  static UserModel fromDictionary(Map<String, Object?> json) => UserModel(
    id: json[UserField.id] as String,
    name: json[UserField.name] as String,
    type: json[UserField.type] as String,
    address: json[UserField.address] as String,
    email: json[UserField.email] as String,
    phoneno: json[UserField.phoneno] as String
  );

  Map<String, Object?> toDictionary()=>{
    UserField.id : id,
    UserField.email : email,
    UserField.address : address,
    UserField.phoneno : phoneno,
    UserField.type : type,
    UserField.name : name
  };
}

class UserField{

  static final List<String> values=[
    id, name, email, phoneno, address, type
  ];

  static final String id='id';
  static final String name='name';
  static final String email='email';
  static final String phoneno='phone';
  static final String address='address';
  static final String type='type';
}