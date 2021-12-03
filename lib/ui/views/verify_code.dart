import 'package:bluetaxiapp/constants/strings.dart';
import 'package:bluetaxiapp/data/model/user_model.dart';
import 'package:bluetaxiapp/ui/shared/app_colors.dart';
import 'package:bluetaxiapp/ui/shared/globle_objects.dart';
import 'package:bluetaxiapp/ui/shared/text_styles.dart';
import 'package:bluetaxiapp/ui/shared/ui_helpers.dart';
import 'package:bluetaxiapp/ui/views/base_widget.dart';
import 'package:bluetaxiapp/ui/views/booking_view.dart';
import 'package:bluetaxiapp/viewmodels/views/verifyCode_view_Model.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class VerifyCodeView extends StatelessWidget {
  final UserModel signInUser;

  VerifyCodeView({required this.signInUser});


  @override
  Widget build(BuildContext context) {
    var phone=Provider.of<UserModel>(context).phoneno;
    //Future<String> phone;
    return BaseWidget<VerifyCodeViewModel>(
        model: VerifyCodeViewModel(repo: Provider.of(context), context: context),
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

                    "${signedINUser.phoneno}",
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
                Form(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 40.0,
                        width: 30.0,
                        color: onSecondaryColor,
                        child: RawKeyboardListener(
                          onKey: (event){
                            model.assignValue(model.boxControllers[0], event.data.keyLabel);
                            FocusScope.of(context).nextFocus();
                          },
                          focusNode: FocusNode(),
                          child: TextFormField(
                            autofocus: true,
                            controller: model.boxControllers[0],
                            focusNode: model.boxFocusNodes[0],
                            textInputAction: TextInputAction.next,
                            onChanged: (_)=>FocusScope.of(context).nextFocus(),
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
                      ),
                      UIHelper.horizontalSpaceSmall,
                      Container(
                        height: 40.0,
                        width: 30.0,
                        color: onSecondaryColor,
                        child: RawKeyboardListener(
                          onKey: (event){
                            if(event.logicalKey == LogicalKeyboardKey.backspace && model.boxControllers[1].text.length==0){
                              model.switchToBackTextField(1,context);
                            }
                            else{
                              model.assignValue(model.boxControllers[1], event.data.keyLabel);
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          focusNode: FocusNode(),
                          child: TextFormField(
                            controller: model.boxControllers[1],
                            focusNode: model.boxFocusNodes[1],
                            textInputAction: TextInputAction.done,
                            onChanged: (_) {
                              FocusScope.of(context).nextFocus();
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
                      ),
                      UIHelper.horizontalSpaceSmall,
                      Container(
                        height: 40.0,
                        width: 30.0,
                        color: onSecondaryColor,
                        child: RawKeyboardListener(
                          onKey: (event){
                            if(event.logicalKey == LogicalKeyboardKey.backspace && model.boxControllers[2].text.length==0){
                              model.switchToBackTextField(2,context);
                            }
                            else{
                              model.assignValue(model.boxControllers[2], event.data.keyLabel);
                              FocusScope.of(context).nextFocus();
                            }

                          },
                          focusNode: FocusNode(),
                          child: TextFormField(
                            controller: model.boxControllers[2],
                            focusNode: model.boxFocusNodes[2],
                            textInputAction: TextInputAction.done,
                            onChanged: (_) {
                              FocusScope.of(context).nextFocus();
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
                      ),
                      UIHelper.horizontalSpaceSmall,
                      Container(
                        height: 40.0,
                        width: 30.0,
                        color: onSecondaryColor,
                        child: RawKeyboardListener(
                          onKey: (event){
                            if(event.logicalKey == LogicalKeyboardKey.backspace && model.boxControllers[3].text.length==0){
                              model.switchToBackTextField(3,context);
                            }
                            else{
                              print("======>${model.boxControllers[0].text},${model.boxControllers[1].text},${model.boxControllers[2].text},${model.boxControllers[3].text}");
                              if(model.boxControllers[0].text=="9"
                                  &&model.boxControllers[1].text=="9"
                                  &&model.boxControllers[2].text=="9"
                                  && model.boxControllers[3].text=="9"){
                                FocusScope.of(context).unfocus();
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => BookingView(),));
                              }
                            }
                          },
                          focusNode: FocusNode(),
                          child: TextFormField(
                            controller: model.boxControllers[3],
                            focusNode: model.boxFocusNodes[3],
                            textInputAction: TextInputAction.done,
                            onChanged: (_) {
                              if(model.boxControllers[0].text=="9"
                                  &&model.boxControllers[1].text=="9"
                                  &&model.boxControllers[2].text=="9"
                                  && model.boxControllers[3].text=="9"){
                                FocusScope.of(context).unfocus();
                                Navigator.push(context, MaterialPageRoute(builder: (context) => BookingView(),));
                              }
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
                      ),
                    ],
                  ),
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
