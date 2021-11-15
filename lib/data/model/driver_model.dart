class Driver {
  final String did;

  Driver({required this.did});
}

class DriverModel {
  late String id;
  String? driverName;
  int? driverStatus;
  String? like;
  String? rating;


  DriverModel({required this.id,
    this.driverName,
    this.driverStatus,
    this.like,
    this.rating,
    });


  DriverModel.initial()
      : id = '0',
        driverName = '',
        driverStatus =0,
        like ='',
        rating='';


  DriverModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    driverName = json['driverName'];
    driverStatus =json['driverStatus'];
    like =json['like'];
    rating=json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['driverName'] = this.driverName;
    data['driverStatus'] = this.driverStatus;
    data['like'] = this.like;
    data['rating'] = this.rating;
    return data;
  }


  assignDriver(){

  }
}

