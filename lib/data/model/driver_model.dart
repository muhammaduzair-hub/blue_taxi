import 'package:enum_to_string/enum_to_string.dart';

class Driver {
  final String did;

  Driver({required this.did});
}

enum DriverStatus {
  Assigned, //Searching
  Unassigned, //Arriving
}

class DriverModel {
  late String id;
  String? driverName;
  DriverStatus? driverStatus;
  String? like;
  String? rating;
  String? phoneNo;
  String? carName;
  String? carNumber;


  DriverModel({required this.id,
    this.driverName,
    this.driverStatus,
    this.like,
    this.rating,
    this.phoneNo,
    this.carName,
    this.carNumber,
    });


  DriverModel.initial()
      : id = '0',
        driverName = '',
        driverStatus =DriverStatus.Unassigned,
        like ='',
        rating='',
        phoneNo='',
        carName='',
        carNumber='';


  DriverModel.fromJson(Map<String, dynamic> json) {

    id = 'json';
    driverName = json['driverName'];
    driverStatus =DriverStatus.Assigned;
    like =json['like'];
    rating=json['rating'];
    phoneNo = json['phoneNo'];
    carName= json['carName'];
    carNumber=json['carNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['driverName'] = this.driverName;
    data['driverStatus'] = this.driverStatus;
    data['like'] = this.like;
    data['rating'] = this.rating;
    data['phoneNo']=this.phoneNo;
    data['carName']=this.carName;
    data['carNumber']=this.carNumber;
    return data;
  }

}

