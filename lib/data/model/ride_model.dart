class RideModel {
  final String id;
 final String paymentMethod;
 final String carType;
 final String expectedBill;
 final String fromAdress;
 final String toAdress;
 final int rideStatus;
 final String riderId;
 final String userId;



  RideModel({
      required this.id,
      required this.paymentMethod,
      required this.carType,
      required this.expectedBill,
      required this.fromAdress,
      required this.toAdress,
      required this.rideStatus,
      required this.riderId,
      required this.userId});

  // RideModel.fromJson(Map<String, dynamic> json) {
  //
  // }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['name'] = this.name;
  //   data['username'] = this.email;
  //   data['phoneno'] = this.phoneno;
  //   data['address'] = this.address;
  //   data['type'] = this.type;
  //   return data;
  // }
}