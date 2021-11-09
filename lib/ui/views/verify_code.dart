import 'package:bluetaxiapp/constants/strings.dart';
import 'package:bluetaxiapp/data/model/user_model.dart';
import 'package:bluetaxiapp/ui/shared/app_colors.dart';
import 'package:bluetaxiapp/ui/shared/text_styles.dart';
import 'package:bluetaxiapp/ui/shared/ui_helpers.dart';
import 'package:bluetaxiapp/ui/views/base_widget.dart';
import 'package:bluetaxiapp/viewmodels/views/verifyCode_view_Model.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class VerifyCodeView extends StatelessWidget {

  TextEditingController oneController = TextEditingController();
  TextEditingController twoController = TextEditingController();
  TextEditingController threeController = TextEditingController();
  TextEditingController fourController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var phone=Provider.of<UserModel>(context).phoneno;
    //Future<String> phone;
    return BaseWidget<VerifyCodeViewModel>(
        model: VerifyCodeViewModel(repo: Provider.of(context)),
    builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: onSecondaryColor,
                elevation: 0.0,
                centerTitle: true,
                title: Text(
                  VerifyCode,
                  style: boldHeading1.copyWith(color: onPrimaryColor),
                ),
                leading: CircleAvatar(
                  radius: 20.0,
                  backgroundColor: Colors.transparent,
                  child: RawMaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    elevation: 4.0,
                    fillColor: Colors.white,
                    child: Icon(
                      Icons.arrow_back_ios_outlined,
                      color: onPrimaryColor,
                      size: 17.0,
                    ),
                    padding: EdgeInsets.all(15.0),
                    shape: CircleBorder(),
                  ),
                ),
              ),
              backgroundColor: onSecondaryColor,
              body: Column(children: <Widget>[
                UIHelper.verticalSpaceLarge,
                Text(
                  verifycodeString1,
                  style: heading2.copyWith(
                      fontWeight: FontWeight.w400, color: onPrimaryColor2),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      //model.inputData().then((value){
                      //  print(value);
                      // });


                      //"${model.inputData().toString()}",

                    "${phone}",
                      style: heading2.copyWith(
                          fontWeight: FontWeight.w400, color: onPrimaryColor2),
                    ),
                    Text(
                      verifycodeString2,
                      style: heading2.copyWith(
                          fontWeight: FontWeight.w400, color: onPrimaryColor2),
                    ),
                  ],
                ),
                UIHelper.verticalSpaceLarge,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 40.0,
                      width: 30.0,
                      color: onSecondaryColor,
                      child: TextFormField(
                        controller: oneController,
                        textInputAction: TextInputAction.next,
                        onChanged: (_) => FocusScope.of(context).nextFocus(),
                        style: numberTextStyle.copyWith(color: secondaryColor),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                        ],
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: secondaryColor, width: 1.0),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: secondaryColor, width: 1.0),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    UIHelper.horizontalSpaceSmall,
                    Container(
                      height: 40.0,
                      width: 30.0,
                      color: onSecondaryColor,
                      child: TextFormField(
                        controller: twoController,
                        textInputAction: TextInputAction.next,
                        onChanged: (_) => FocusScope.of(context).nextFocus(),
                        style: numberTextStyle.copyWith(color: secondaryColor),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                        ],
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: secondaryColor, width: 1.0),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: secondaryColor, width: 1.0),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    UIHelper.horizontalSpaceSmall,
                    Container(
                      height: 40.0,
                      width: 30.0,
                      color: onSecondaryColor,
                      child: TextFormField(
                        controller: threeController,
                        textInputAction: TextInputAction.next,
                        onChanged: (_) => FocusScope.of(context).nextFocus(),
                        style: numberTextStyle.copyWith(color: secondaryColor),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                        ],
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: secondaryColor, width: 1.0),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: secondaryColor, width: 1.0),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    UIHelper.horizontalSpaceSmall,
                    Container(
                      height: 40.0,
                      width: 30.0,
                      color: onSecondaryColor,
                      child: TextFormField(
                        controller: fourController,
                        textInputAction: TextInputAction.done,
                        onChanged: (_) {
                          if(oneController.text=="9"
                              &&twoController.text=="9"
                              &&threeController.text=="9"
                              && oneController.text=="9"){
                          FocusScope.of(context).unfocus();
                          print("9999 Done");}
                        },
                        style: numberTextStyle.copyWith(color: secondaryColor),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                        ],
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: secondaryColor, width: 1.0),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: secondaryColor, width: 1.0),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                UIHelper.verticalSpaceMedium,
                InkWell(
                  child: Text(
                    "$resend_code ${model.start}",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0,
                        color: onPrimaryColor2),
                  ),
                  onTap: () {
                    model.changeData(resend_code);
                  },
                ),
                UIHelper.verticalSpaceXLarge,
                Container(
                  padding: EdgeInsets.all(20.0),
                  height: 60.0,
                  width: double.infinity,
                  color: secondaryColor,
                  child: Text(
                    verify_press_call,
                    textAlign: TextAlign.center,
                    style: buttonTextStyle.copyWith(
                        fontWeight: FontWeight.w800, color: onSecondaryColor),
                  ),
                )
              ]),
            ));
          }
        }
