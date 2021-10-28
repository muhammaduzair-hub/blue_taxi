
import 'package:bluetaxiapp/provider_practice/data/db_files/user_dto_fields.dart';

class UserDTO{
  final int? id;
  final String firstName;
  final String lastName;
  final String? password;
  final String email;

  UserDTO({
    this.id,
    required this.firstName,
    required this.lastName,
    this.password,
    required this.email
  });

  factory UserDTO.fromDictionary(Map<String,dynamic> dict){
    return UserDTO(
        id:dict['_id'],
        firstName: dict['firstName'],
        lastName: dict['lastName'],
        email: dict['email']
    );
  }

  Map<String, Object?> toDictionary()=>{
    UserDTOFields.email : email,
    UserDTOFields.id : id,
    UserDTOFields.lastName:lastName,
    UserDTOFields.firstName:firstName
  };


}