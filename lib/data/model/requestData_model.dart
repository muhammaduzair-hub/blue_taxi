class RequestDataModel{
  final Addresses? address;
  final String? carType;
  final DateTime? createDate;
  final String? expectedBill;
  final Payment? payment;
  final int? rideStatus;
  final String? riderId;
  final String? userId;

  RequestDataModel( {
    this.carType,
    this.createDate,
    this.expectedBill,
        this.address,
        this.payment,
        this.rideStatus,
        this.riderId,
        this.userId
  });

  factory RequestDataModel.fromJson(Map<String, dynamic> json){
    return RequestDataModel(
      carType: json["carType"],
        createDate: DateTime.fromMillisecondsSinceEpoch(
            json['createDate'].millisecondsSinceEpoch),
      //createDate: DateTime.parse(json['createDate'] as String),
      expectedBill: json["expectedBill"],
      address: Addresses.fromJson(json["Addresses"]),
      payment: Payment.fromJson(json["payment"]),
      riderId: json["riderId"],
      rideStatus: json["rideStatus"],
      userId: json["userId"],
    );
  }
}

class Payment {
  final String? card_no;
  final String? id;
  final String? type;

  Payment({
    this.card_no,
    this.id,
    this.type
  });

  factory Payment.fromJson(Map<String, dynamic> json){
    return Payment(
      card_no: json["card_no"],
      id: json["id"],
      type: json["type"],
    );
  }
}
class Addresses {
  final From? from;
  final From? to;
  Addresses(
      {
        this.from,
        this.to,
      });
  factory Addresses.fromJson(Map<String, dynamic> json){
    return Addresses(
      from:From.fromJson(json["from"]),
       to:From.fromJson(json["to"]),
    );
  }

}
class From {
  final double? lat;
  final double? lng;
  final String? place_name;

  From({
    this.lng,
    this.place_name,
    this.lat});

  factory From.fromJson(Map<String, dynamic> json){
    return From(
      lat: json["lat"],
      lng: json["lng"],
      place_name: json["place_name"],
    );
  }
}