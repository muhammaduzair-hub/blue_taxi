import 'package:bluetaxiapp/constants/strings.dart';
import 'package:bluetaxiapp/data/model/requestData_model.dart';
import 'package:bluetaxiapp/data/repository/auth_repository.dart';
import 'package:bluetaxiapp/viewmodels/base_model.dart';

class ReceiptViewModel extends BaseModel {
  final AuthRepository repo;
  late String state;
  late String requestId;
  late RequestDataModel requestDataModel;
  late DateTime endingTime;

  ReceiptViewModel({required this.repo, required this.requestId}) : super(false){
    getRide(requestId);
  }

    Future<void> getRide(String requestId) async {
      setBusy(true);
      requestDataModel= await repo.getRide(requestId);
      //DateTime date = requestDataModel.createDate!.toLocal();
      try{
        int v= double.parse(requestDataModel.expectedBill!).toInt();
        endingTime = requestDataModel.createDate!.add(Duration(minutes: v));
      }
      catch(e){
        print("======================Something Wnet Wrong ");
      }
     // print("*********${requestDataModel.address!.from.toString()}");
      setBusy(false);
  }

}