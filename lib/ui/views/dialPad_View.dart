import 'package:bluetaxiapp/ui/shared/app_colors.dart';
import 'package:bluetaxiapp/ui/widgets/leading_back_button.dart';
import 'package:flutter_dialpad/flutter_dialpad.dart';
import 'package:flutter/material.dart';

class DialPadView extends StatelessWidget {
  const DialPadView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
        leading: LeadingBackButton(
          radius: 30.0,
          ontap: () {
            Navigator.pop(context);
          },
          icon: AssetImage('asset/icons/back_btn.png'),
        ),
      ),
      body: Container(
          color: Colors.black,
          child: DialPad(
              enableDtmf: true,
              outputMask: "0000 0000000",
              buttonColor: onPrimaryColor2,
              buttonTextColor: secondaryColor,
              backspaceButtonIconColor: onPrimaryColor2,
              makeCall: (number){
                //Make Call
                print(number);
              }
          )
      ),
    );
  }
}
