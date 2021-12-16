import 'package:bluetaxiapp/ui/shared/app_colors.dart';
import 'package:bluetaxiapp/ui/shared/globle_objects.dart';
import 'package:bluetaxiapp/ui/shared/text_styles.dart';
import 'package:bluetaxiapp/ui/views/base_widget.dart';
import 'package:bluetaxiapp/ui/views/signin_signup_view.dart';
import 'package:bluetaxiapp/ui/widgets/responsive_ui_widgets.dart';
import 'package:bluetaxiapp/viewmodels/views/my_profile_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class MyProfileView extends StatelessWidget {
  const MyProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BaseWidget<MyProfileViewModel>(
        model: MyProfileViewModel(repo: Provider.of(context)),
    builder: (context, model, child) => SafeArea(
      child: Scaffold(
          body: Container(
            height: height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //BACK BUTTON
                Padding(
                  padding: EdgeInsets.only(
                      top: width * 1 / 20, left: width * 1 / 20),
                  child: LeadingBackButton(
                      image: const AssetImage("asset/icons/back_arrow.png"),
                      ontap: () {
                        Navigator.pop(context);
                      }),
                ),

                //CARD AND NOTIFICATION TOGGLE
                Padding(
                  padding: EdgeInsets.all(width * 1 / 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //PROFILE PICTURE
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(70),
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.3),
                            )),
                        child: CustomImage(
                          ontap: () {},
                          image: const AssetImage("asset/images/photo_user.png"),
                          height: height * 1 / 8,
                          width: width * 1 / 6,
                        ),
                      ),

                      //NAME TEXT
                       Text(
                        signedINUser.name!,
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                      Container(height: height * 0.5 / 20,),

                      //INFO CARD
                      Material(
                        elevation: 15,
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          height: height / 3,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: width * 1 / 20,
                                vertical: height * 1 / 70),
                            child: Center(
                              child: Align(
                                alignment: Alignment.center,
                                child: ListView(
                                  physics: NeverScrollableScrollPhysics(),
                                  children: [
                                    // i use hard coded values here because we will fetch these texts from models
                                    listTile(
                                        icon: Icons.call,
                                        title: signedINUser.phoneno!),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 65.0),
                                      child: Divider(
                                        height: 10,
                                        thickness: 1.0,
                                      ),
                                    ),
                                    listTile(
                                        icon: Icons.email,
                                        title: signedINUser.email!),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 65.0),
                                      child: Divider(
                                        height: 10,
                                        thickness: 1.0,
                                      ),
                                    ),
                                    listTile(
                                        icon: Icons.facebook,
                                        title: "@carsonmobility"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      //Notification Toggle
                      ListTile(
                          title: Text(
                            "Notification",
                          ),
                          subtitle: Text("For Recieving Driver Message"),
                          trailing: Switch(
                            activeColor: Colors.blue,
                            inactiveThumbColor: Colors.grey,
                            onChanged: (v) {
                             model.changeSwitchState();
                            },
                           value: model.switchState,
                          )),

                      Container(height: height * 0.9 / 20,),

                      //LOGOUT BUTTON
                      SizedBox(
                        height: height * 1.5 / 18,
                        width: double.infinity,
                        child: PrimaryButton(
                          text: const Text("Logout"),
                          ontap: () {
                            _showMyDialog(context,model);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ))),
    );
  }


  Future<void> _showMyDialog(BuildContext context,
      MyProfileViewModel model) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Would you like to logout?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () async {
                Navigator.of(context).pop();
                await model.userSignOutFromSqflite();
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                    builder: (context) => new SignInSignUpView()), (
                    route) => false);
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

          ],
        );
      },
    );
  }


  Widget listTile({required IconData icon, required String title}) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(icon,color: onSecondaryColor,size: 30,),
        backgroundColor: secondaryColor2,
      ),
      title: Text(title,style: heading2,),
    );
  }
}





