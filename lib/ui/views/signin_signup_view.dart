import 'package:bluetaxiapp/constants/app_contstants.dart';
import 'package:bluetaxiapp/constants/strings.dart';
import 'package:bluetaxiapp/ui/shared/app_colors.dart';
import 'package:bluetaxiapp/ui/shared/text_styles.dart';
import 'package:bluetaxiapp/ui/shared/ui_helpers.dart';
import 'package:bluetaxiapp/ui/views/base_widget.dart';
import 'package:bluetaxiapp/ui/views/user_menu_view.dart';
import 'package:bluetaxiapp/ui/views/verify_code.dart';
import 'package:bluetaxiapp/ui/widgets/primary_button.dart';
import 'package:bluetaxiapp/viewmodels/base_model.dart';
import 'package:bluetaxiapp/ui/widgets/custom_text_field.dart';
import 'package:bluetaxiapp/viewmodels/views/signin_signup_view_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';



class SignInSignUpView extends StatelessWidget {
   SignInSignUpView({Key? key}) : super(key: key);
   TextEditingController nameController = TextEditingController();
   TextEditingController emailController = TextEditingController();
   TextEditingController passwordController = TextEditingController();
   TextEditingController numberController = TextEditingController();
   PageController _pageController = PageController(initialPage: 0);



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return PageView(
      controller: _pageController,
      children: [
        signIn(context, size),
        signUp(context, size),
      ],
    );

  }
 
   Widget signUp(BuildContext context, Size size){

     return BaseWidget<SignInSignUpViewModel>(
       model: SignInSignUpViewModel(repo: Provider.of(context)),
       builder: (context, model, child) => Scaffold(
         appBar: AppBar(
           elevation: 0.0,
           backgroundColor: Colors.transparent,
           shadowColor: Colors.transparent,
           title: Text(LabelSignup,style: boldHeading1.copyWith(color: onPrimaryColor)),
           centerTitle: true,
         ),
         body: Form(
           child: SingleChildScrollView(
               child: SizedBox(
                 height: size.height-120,
                 width: double.infinity,
                 child: Padding(
                   padding: UIHelper.signInSignUpPagePadding,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Spacer(flex: 2,),
                       Text(LabelName,style: boldHeading3),
                       UIHelper.verticalSpaceSmall,
                       CustomTextField(
                         controller: nameController,
                       ),
                       UIHelper.verticalSpaceMedium,
                       Text(LabelEmail,style: boldHeading3),
                       UIHelper.verticalSpaceSmall,
                       CustomTextField(controller: emailController),
                       UIHelper.verticalSpaceMedium,
                       Text(LabelMobile,style: boldHeading3),
                       UIHelper.verticalSpaceSmall,
                       CustomTextField(controller: numberController,),
                       UIHelper.verticalSpaceMedium,
                       Text(LabelPassword,style: boldHeading3),
                       UIHelper.verticalSpaceSmall,
                       CustomTextField(
                         controller: passwordController,
                         showPassword: true,
                       ),
                       UIHelper.verticalSpaceLarge,
                       Container(
                         width: double.infinity,
                         height: 50,
                         child: PrimaryButton(
                           text: Text(LabelSignup,style: buttonTextStyle,),
                           ontap:() async {
                             bool passAns=model.validatePassword(passwordController.text);
                              bool emailAns=model.validateEmail(emailController.text);
                              bool mobilAns=model.validateMobileNumber(numberController.text) ;
                              bool nameAns = model.validateName(nameController.text);
                               if(passAns==true && emailAns==true && mobilAns==true && nameAns==true){
                                 //Send Data to a method inside Model Class to access Database
                                 print("Data Is true");
                                 dynamic result= model.signup(nameController, emailController,numberController, passwordController);
                                 print(result);
                                 if(result==null){
                                   print("cannot proceed");
                                 }
                                 else
                                   Navigator.push(context, new MaterialPageRoute(
                                       builder: (context) => new VerifyCodeView())
                                   );
                             }
                               //else Check Which Validator is wrong and throw respective error

                               },
                         ),
                       ),
                       //SizedBox(height: 200,),
                       Spacer(flex: 2,),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text(LabelAlreadyHaveAccount, style: heading3.copyWith(color: onPrimaryColor2 )),
                           InkWell(
                             onTap: (){
                               _pageController.previousPage(duration: Duration(milliseconds: 700), curve: Curves.ease);

                             },
                             child: Text(
                               LabelSignIn, style: heading2.copyWith(color: secondaryColor ),
                             ),
                           ),
                         ],
                       ),
                     ],
                   ),
                 ),
               )
           ),
         ),
       ),
     );
   }

   Widget signIn(BuildContext context, Size size){
     return BaseWidget<SignInSignUpViewModel>(  //we use signup model for both
       model: SignInSignUpViewModel(repo: Provider.of(context)),
       builder: (context, model, child) => Scaffold(
         appBar: AppBar(
         elevation: 0.0,
         backgroundColor: Colors.transparent,
         shadowColor: Colors.transparent,
         title: Text(LabelSignIn,style: boldHeading1.copyWith(color: onPrimaryColor)),
         centerTitle: true,
       ),
         body: Form(
           child: SingleChildScrollView(
               child: SizedBox(
                 height: size.height-120,
                 width: double.infinity,
                 child: Padding(
                   padding: UIHelper.signInSignUpPagePadding,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Spacer(flex: 2,),
                       Text(LabelMobile,style: boldHeading3),
                       UIHelper.verticalSpaceSmall,
                       CustomTextField(
                         controller: numberController,
                       ),
                       UIHelper.verticalSpaceMedium,
                       Text(LabelPassword,style: boldHeading3),
                       UIHelper.verticalSpaceSmall,
                       CustomTextField(controller: passwordController),
                       //
                       UIHelper.verticalSpaceLarge,
                       Container(
                         width: double.infinity,
                         height: 50,
                         child: PrimaryButton(
                           text: Text(LabelSignIn,style: buttonTextStyle,),
                           ontap:(){

                             bool passAns=model.validatePassword(passwordController.text);
                             bool mobilAns=model.validateMobileNumber(numberController.text);
                             if(passAns==true && mobilAns==true){
                               //Send Data to a method inside Model Class to access Database
                               print("Data Is true");
                               dynamic result= model.signin( numberController, passwordController);
                               print(result);
                               if(result==null){
                                 print("cannot Signin with those credentials");
                               }
                               else
                                 Navigator.push(context, new MaterialPageRoute(
                                     builder: (context) => new VerifyCodeView())
                                 );
                             }
                           } ,
                         ),
                       ),
                       UIHelper.verticalSpaceMedium,
                       UIHelper.verticalSpaceMedium,
                       Expanded(

                         child:  Row(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: <Widget>[
                             Container(
                               width: 85.0,
                               height: 1,
                               color: onPrimaryColor,
                             ),
                             Container(
                               child: Text(
                                LabelOrSignInWith,
                                 style: heading3.copyWith(color: onPrimaryColor,fontWeight: FontWeight.w700)
                               ),
                             ),
                             Container(
                               width: 85.0,
                               height: 1,
                               color: onPrimaryColor,
                             ),
                           ],
                         ),
                       ),
                       Row(
                         crossAxisAlignment: CrossAxisAlignment.center,
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         children: <Widget>[
                           CircleAvatar(
                             radius: 25.0,
                             backgroundColor: Color(0xffD5DDE0),
                             child: IconButton(
                               color: Colors.white,
                               iconSize: 32.0,
                               onPressed: (){
                                 //Send to Facebook Page Login
                               },
                               icon:  FaIcon(FontAwesomeIcons.facebookF),
                             ),
                           ),
                           CircleAvatar(
                             radius: 25.0,
                             backgroundColor: Color(0xffD5DDE0),
                             child: IconButton(
                               color: Colors.white,
                               iconSize: 30.0,
                               onPressed: (){
                                 //Send to Twitter Page Login
                               },
                               icon:  FaIcon(FontAwesomeIcons.twitter),
                             ),
                           ),
                           CircleAvatar(
                             radius: 25.0,
                             backgroundColor: Color(0xffD5DDE0),
                             child: IconButton(
                               color: Colors.white,
                               iconSize: 28.0,
                               onPressed: (){
                                 //Send to Gmail Page Login
                               },
                               icon:  FaIcon(FontAwesomeIcons.google),
                             ),
                           )
                           // CircleAvatar(
                           //   radius: 25,
                           //   backgroundImage: AssetImage(
                           //     'assets/facebook_icon.png',
                           //   ),
                           // )
                         ],
                       ),
                       Spacer(flex: 2,),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text(LabelDontHaveAccount, style: heading2.copyWith(color: onPrimaryColor2 )),
                           InkWell(
                             onTap: (){

                               _pageController.nextPage(duration: Duration(milliseconds: 700), curve: Curves.ease);
                             },
                             child: Text(
                               LabelSignup, style: heading2.copyWith(color: secondaryColor ),
                             ),
                           ),
                         ],
                       ),
                     ],
                   ),
                 ),
               )
           ),
         ),
       ),
     );
   }
}


