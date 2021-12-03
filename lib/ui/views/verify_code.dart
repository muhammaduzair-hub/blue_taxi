import 'package:bluetaxiapp/constants/strings.dart';
import 'package:bluetaxiapp/data/model/user_model.dart';
import 'package:bluetaxiapp/ui/shared/app_colors.dart';
import 'package:bluetaxiapp/ui/shared/text_styles.dart';
import 'package:bluetaxiapp/ui/shared/ui_helpers.dart';
import 'package:bluetaxiapp/ui/views/base_widget.dart';
import 'package:bluetaxiapp/ui/views/booking_view.dart';
import 'package:bluetaxiapp/viewmodels/views/verifyCode_view_Model.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class VerifyCodeView extends StatelessWidget {
  final UserModel signInUser;

  VerifyCodeView({required this.signInUser});


  @override
  Widget build(BuildContext context) {

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
                      "${signInUser.phoneno}",
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
                    key: model.formKey,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 50),
                        child: PinCodeTextField(
                          appContext: context,
                          pastedTextStyle: TextStyle(
                            color: Colors.green.shade600,
                            fontWeight: FontWeight.bold,
                          ),
                          length: 4,
                          animationType: AnimationType.fade,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.underline ,
                          ),
                          cursorColor: Colors.black,
                          animationDuration: Duration(milliseconds: 300),
                          errorAnimationController: model.errorController,
                          controller: model.textEditingController,
                          keyboardType: TextInputType.number,
                          onCompleted: (v) {
                            if(model.textEditingController.text=="9999"){
                              model.hasError = false;

                              model.setBusy(false);
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => BookingView(),));
                            }
                            else
                              {
                                model.errorController!.add(ErrorAnimationType
                                    .shake); // Triggering error shake animation
                                model.hasError = true;
                                model.textEditingController.text="";
                                model.setBusy(false);
                              }
                          },
                          onChanged: (value) {
                            print(value);
                            model.currentText = value;
                            model.setBusy(false);
                          },
                          beforeTextPaste: (text) {
                            print("Allowing to paste $text");
                            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                            //but you can show anything you want here, like your pop up saying wrong paste format or etc
                            return true;
                          },
                        )),
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
