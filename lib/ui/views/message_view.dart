import 'package:bluetaxiapp/data/model/message_model.dart';
import 'package:bluetaxiapp/ui/shared/app_colors.dart';
import 'package:bluetaxiapp/ui/shared/text_styles.dart';
import 'package:bluetaxiapp/ui/widgets/custom_text_field.dart';
import 'package:bluetaxiapp/ui/widgets/leading_back_button.dart';
import 'package:flutter/material.dart';

class MessageView extends StatelessWidget {
  MessageView({Key? key}) : super(key: key);

  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: onSecondaryColor,
            centerTitle: true,
            title: Column(
              children: [
                Text(
                  "Patrick",
                  style: boldHeading1.copyWith(color: onPrimaryColor),
                ),
                Text(
                  "Patrick",
                  style: textRegular.copyWith(
                      fontWeight: FontWeight.w400, color: secondaryColor2),
                ),
              ],
            ),
            leading: LeadingBackButton(
              radius: 30.0,
              ontap: () {
                Navigator.pop(context);
              },
              icon: AssetImage('asset/icons/back_btn.png'),
            ),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.all(5.0),
                child: LeadingBackButton(
                  radius: 30.0,
                  ontap: () {},
                  icon: AssetImage('asset/images/Group.png'),
                ),
              ),
            ]),
        body: Stack(
          children: <Widget>[
            ListView.builder(
              itemCount: messages.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 10,bottom: 10),
              //physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                return Container(
                  padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
                  child: Align(
                    alignment: (messages[index].messageType == "receiver"?Alignment.topLeft:Alignment.topRight),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: (messages[index].messageType  == "receiver"?onPrimaryColor3:secondaryColor),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Text(messages[index].messageContent, style: TextStyle(color: (messages[index].messageType  == "receiver"?onPrimaryColor:onSecondaryColor),fontSize: 15),),
                    ),
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                height: 70,
                width: double.infinity,
                color: onSecondaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        // child: CustomTextField(
                        //   controller: messageController,
                        // ),
                        child: TextField(
                          controller: messageController,
                          cursorColor: secondaryColor,
                          style:heading2.copyWith(color: onPrimaryColor),
                          enabled: true,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Color(0xffD5DDE0)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Color(0xffD5DDE0)),
                            ),
                            fillColor: onSecondaryColor,
                            filled: true,
                            hintText: "Start typing here...",
                            hintStyle:
                                heading2.copyWith(color: onPrimaryColor2),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      LeadingBackButton(
                        radius: 50.0,
                        ontap: () {},
                        icon: AssetImage('asset/icons/nav_btn.png'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
