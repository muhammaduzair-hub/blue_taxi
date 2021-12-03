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
              body: SingleChildScrollView(
                child: Column(children: <Widget>[
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
                              if(event.logicalKey!=LogicalKeyboardKey.backspace){
                                model.assignValue(model.firstController, event.data.keyLabel);
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            focusNode: FocusNode(),
                            child: TextFormField(
                              autofocus: true,
                              focusNode: model.boxFocusNodes[0],
                              controller: model.firstController,
                              textInputAction: TextInputAction.next,
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
                              if(event.logicalKey == LogicalKeyboardKey.backspace && model.secondController.text.length==0){
                                // model.firstController.text="";
                                // model.setBusy(false);
                                model.switchToBackTextField(1, context);
                              }
                              else{
                                model.assignValue(model.secondController, event.data.keyLabel);
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            focusNode: FocusNode(),
                            child: TextFormField(
                              autofocus: true,
                              focusNode: model.boxFocusNodes[1],
                              controller: model.secondController,
                              textInputAction: TextInputAction.next,
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
                              if(event.logicalKey == LogicalKeyboardKey.backspace && model.thirdController.text.length==0){
                                //model.secondController.text="";
                                //model.setBusy(false);
                                //FocusScope.of(context).previousFocus();
                                model.switchToBackTextField(2, context);
                              }
                              else{
                                model.assignValue(model.thirdController, event.data.keyLabel);
                                FocusScope.of(context).nextFocus();
                              }

                            },
                            focusNode: FocusNode(),
                            child: TextFormField(
                              focusNode: model.boxFocusNodes[2],
                              controller: model.thirdController,
                              textInputAction: TextInputAction.next,
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
                              if(event.logicalKey == LogicalKeyboardKey.backspace && model.fourthController.text.length==0){
                               // model.thirdController.text="";
                               // model.setBusy(false);
                               // FocusScope.of(context).previousFocus();
                                model.switchToBackTextField(3, context);
                              }
                              else{
                                model.assignValue(model.fourthController, event.data.keyLabel);
                                print("1++++++++++++++++++++++++>${model.firstController.text}\n2=+++++++++++++++++++>${model.secondController.text}\n3========================>${model.thirdController.text}");
                                print("4=++++++++++++++++++++++++>${model.fourthController.text}");
                                if(model.firstController.text=="9"
                                    &&model.secondController.text=="9"
                                    &&model.thirdController.text=="9"
                                    && model.fourthController.text=="9"){
                                  FocusScope.of(context).unfocus();
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => BookingView(),));
                                }
                              }

                            },
                            focusNode: FocusNode() ,
                            child: TextFormField(
                              focusNode: model.boxFocusNodes[3],
                              controller: model.fourthController,
                              textInputAction: TextInputAction.done,
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
              ),
            ));
          }
        }
