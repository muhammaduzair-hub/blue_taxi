
import 'package:bluetaxiapp/data/model/post_sample.dart';
import 'package:bluetaxiapp/data/remote/api_sample.dart';

import '../base_model.dart';

class CustomTextFieldViewModel extends BaseModel {
  late bool obscureText = true;

  CustomTextFieldViewModel() : super(false);

  switchState(){
    setBusy(true);
    obscureText=!obscureText;
    setBusy(false);
  }


}
