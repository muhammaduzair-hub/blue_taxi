import 'package:bluetaxiapp/constants/strings.dart';
import 'package:bluetaxiapp/data/repository/auth_repository.dart';
import 'package:bluetaxiapp/viewmodels/base_model.dart';

class ReceiptViewModel extends BaseModel {
  final AuthRepository repo;
  late String state;

  ReceiptViewModel({required this.repo}) : super(false);

}