import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Request {
  final String rid;

  Request({required this.rid});
}

class RequestModel {
  String id='0';
  String? paymentMethod;
  String? carType;
  String? expectedBill;
  String? fromAddress;
  String? rideStatus;
  String? riderId;
  String? toAddress;
  String? userId;

  RequestModel({
    required this.id,
    required this.paymentMethod,
    required this.carType,
    required this.expectedBill,
    required this.fromAddress,
    required this.rideStatus,
    required this.riderId,
    required this.toAddress,
    required this.userId});


  RequestModel.initial()
      : id = '0',
  paymentMethod = '',
  carType ='',
  expectedBill ='',
  fromAddress='',
  rideStatus='',
  riderId='',
  toAddress='',
  userId='';


   factory RequestModel.fromJson(Map<String, dynamic>? json, String uid, String DriverID) {
    return RequestModel(
        id: uid,
        expectedBill: json!['expectedBill'].toString(),
        userId: json['userId'].toString(),
        rideStatus: "1",
        riderId: DriverID,
        paymentMethod: json['paymentMethod'].toString(),
        carType: json['carType'].toString(),
        toAddress: json['toAddress'].toString(),
        fromAddress: json['fromAddress'].toString(),
    );
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['paymentMethod'] = this.paymentMethod;
    data['carType'] = this.carType;
    data['expectedBill'] = this.expectedBill;
    data['fromAddress'] = this.fromAddress;
    data['rideStatus'] = this.rideStatus;
    data['riderId'] = this.riderId;
    data['toAddress'] = this.toAddress;
    data['uid'] = this.userId;
    return data;
  }
}

