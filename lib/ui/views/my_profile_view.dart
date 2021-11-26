
import 'package:bluetaxiapp/constants/strings.dart';
import 'package:bluetaxiapp/ui/shared/app_colors.dart';
import 'package:bluetaxiapp/ui/shared/text_styles.dart';
import 'package:bluetaxiapp/ui/shared/ui_helpers.dart';
import 'package:bluetaxiapp/ui/views/base_widget.dart';
import 'package:bluetaxiapp/ui/views/signin_signup_view.dart';
import 'package:bluetaxiapp/ui/widgets/leading_back_button.dart';
import 'package:bluetaxiapp/ui/widgets/primary_button.dart';
import 'package:bluetaxiapp/viewmodels/views/my_profile_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class MyProfileView extends StatelessWidget {
  const MyProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return BaseWidget<MyProfileViewModel>(
      model: MyProfileViewModel(repo: Provider.of(context)),
      builder: (context, model, child) => Scaffold(
        body: Padding(
          padding: UIHelper.pagePaddingSmall,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LeadindBackButton(icon: AssetImage("asset/icons/nav btn.png"),ontap: (){Navigator.pop(context);},),
              UIHelper.verticalSpaceMedium,
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: onPrimaryColor2.withOpacity(0.1),
                      radius: 40,
                      backgroundImage: AssetImage("asset/icons/photo user.png"),
                      //child: Icon(Icons.person,size: 50,color: onPrimaryColor,),
                    ),
                    UIHelper.verticalSpaceSmall,
                    Text("Carson",style: boldHeading1,),
                    UIHelper.verticalSpaceLarge,
                    Material(
                      elevation: 15,
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 3,vertical: 10),
                        height: 200,
                        width: screenSize.width-40,
                        child: ListView(
                          padding: EdgeInsets.all(8),
                          children: [
                            // i use hard coded values here because we will fetch these texts from models
                            listTile(icon: Icons.call,title: "+1 926 483 32 52"),
                            Padding(padding: EdgeInsets.only(left: 61.58,right: 20),child: Divider(height: 3,color: secondaryColor2,),),
                            listTile(icon: Icons.email,title: "Carson@mobility.com"),
                            Padding(padding: EdgeInsets.only(left: 61.58,right: 20),child: Divider(height: 3,color: secondaryColor2,),),
                            listTile(icon: FontAwesomeIcons.facebookF,title: "@carsonmobility"),
                          ],
                        ),
                      ),
                    ),
                    UIHelper.verticalSpaceMedium,
                    ListTile(
                      title: Text(LabelNotiication,style: boldHeading2,),
                      subtitle: Text(LabelForRecievingDriverMessage),
                      trailing: Switch(
                        value: model.switchState,
                        activeColor: secondaryColor,
                        inactiveThumbColor: onSecondaryColor,
                        onChanged: (v){
                          model.changeSwitchState();
                        },
                      )
                    ),
                    // Spacer(),
                    UIHelper.verticalSpaceLarge,
                    UIHelper.verticalSpaceMedium,
                    Container(
                      height: 45,
                      width: double.infinity,
                      child: PrimaryButton(
                        text: Text(LabelDeleteAccount,style: boldHeading2,),
                        ontap: (){
                          Navigator.push(context, new MaterialPageRoute(
                              builder: (context) => new SignInSignUpView()));
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );


  }

  Widget listTile({required IconData icon, required String title}){
    return ListTile(
      leading: CircleAvatar(
        child: Icon(icon,color: onSecondaryColor,size: 30,),
        backgroundColor: secondaryColor2,
      ),
      title: Text(title,style: heading2,),
    );
  }
}






