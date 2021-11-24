
import 'package:bluetaxiapp/data/model/driver_model.dart';
import 'package:bluetaxiapp/data/repository/auth_repository.dart';
import 'package:bluetaxiapp/viewmodels/base_model.dart';

class TripViewModel extends BaseModel{
  late AuthRepository authRepository;
  final String driverId;
  late DriverModel? driverDocument;
  var nice;


  TripViewModel({required this.authRepository,required this.driverId,}) : super(false) {
    getDriverr(driverId);
    driverDocument = DriverModel(id: '');
  }


  Future<void> getDriverr(driverId) async {
    setBusy(true);
    driverDocument= await authRepository.getDriver(driverId);
    print(driverDocument!.driverName);
    setBusy(false);
  }
}