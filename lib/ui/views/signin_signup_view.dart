import 'package:bluetaxiapp/constants/strings.dart';
import 'package:bluetaxiapp/ui/shared/app_colors.dart';
import 'package:bluetaxiapp/ui/shared/globle_objects.dart';
import 'package:bluetaxiapp/ui/shared/text_styles.dart';
import 'package:bluetaxiapp/ui/shared/ui_helpers.dart';
import 'package:bluetaxiapp/ui/views/base_widget.dart';
import 'package:bluetaxiapp/ui/views/verify_code.dart';
import 'package:bluetaxiapp/ui/widgets/primary_button.dart';
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
   TextEditingController snumberController = TextEditingController();
   TextEditingController spasswordController = TextEditingController();

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
       builder: (context, model, child) =>SafeArea(
         child: Scaffold(
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
                     padding: UIHelper.pagePaddingSmall.copyWith(bottom: 0),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                        Spacer(),
                         Text(LabelName,style: boldHeading3),
                         UIHelper.verticalSpaceSmall,
                         CustomTextField(controller: nameController, keyboardType: TextInputType.name),
                         if(model.nameState==false)Text(labelNameError, style: TextStyle(color: errorMessage),),

                         UIHelper.verticalSpaceMedium,
                         Text(LabelEmail,style: boldHeading3),
                         UIHelper.verticalSpaceSmall,
                         CustomTextField(controller: emailController, keyboardType: TextInputType.emailAddress,),
                         if(model.duplicateEmail)Text("Email already exists!", style: TextStyle(color: errorMessage),)
                         else if(model.emailState==false)Text(labelEmailError, style: TextStyle(color: errorMessage),),

                         UIHelper.verticalSpaceMedium,
                         Text(LabelMobile,style: boldHeading3),
                         UIHelper.verticalSpaceSmall,
                         CustomTextField(controller: numberController, keyboardType: TextInputType.number,),
                         if(model.duplicatePhone)Text("Phone Number Already exists!", style: TextStyle(color: errorMessage))
                         else if(model.phoneState==false)Text(labelPhoneNoError, style: TextStyle(color: errorMessage),),

                         UIHelper.verticalSpaceMedium,
                         Text(LabelPassword,style: boldHeading3),
                         UIHelper.verticalSpaceSmall,
                         CustomTextField(controller: passwordController, showPassword: true,),
                         if(model.passState==false)Text(labelPasswordError, style: TextStyle(color: errorMessage),),

                         UIHelper.verticalSpaceMedium,
                         Container(
                           width: double.infinity,
                           height: 50,
                           child:
                           model.busy?
                           Center(child: CircularProgressIndicator(),) :
                           PrimaryButton(
                             text: Text(LabelSignup,style: buttonTextStyle,),
                             ontap:() async {
                               model.duplicateEmail = false;
                               model.duplicatePhone = false;
                               model.validateName(nameController.text);
                               await model.validateEmail(emailController.text,numberController.text);
                               model.validateMobileNumber(numberController.text);
                               model.validatePassword(passwordController.text);

                               if(model.validateName(nameController.text)
                                     && await model.validateEmail(emailController.text,numberController.text)
                                     && model.validateMobileNumber(numberController.text)
                                     && model.validatePassword(passwordController.text)){

                                   //Send Data to a method inside Model Class to access Database
                                   await model.signUp(nameController, emailController,numberController, passwordController);

                                   //Route to VerifyCode View

                                   await model.signin( numberController, passwordController);
                                   if(model.signedIdnUser.id==''){
                                     model.error=true;
                                     // print("cannot Signin with those credentials");
                                   }
                                   else {
                                     Navigator.push(context, new MaterialPageRoute(
                                         builder: (context) => new VerifyCodeView(
                                           signInUser: model.signedIdnUser,
                                         ))
                                     );
                                   }


                                   nameController.text="";
                                   emailController.text="";
                                   numberController.text="";
                                   passwordController.text="";
                                   model.setBusy(false);
                                   //_pageController.previousPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
                               }
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
                                 nameController.text="";
                                 emailController.text="";
                                 numberController.text="";
                                 passwordController.text="";
                                 model.setBusy(false);
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
       ),
     );
   }

   Widget signIn(BuildContext context, Size size){
     return BaseWidget<SignInSignUpViewModel>(  //we use signup model for both
       model: SignInSignUpViewModel(repo: Provider.of(context)),
       builder: (context, model, child) =>SafeArea(
         child: Scaffold(
           appBar: AppBar(
           elevation: 0.0,
           backgroundColor: Colors.transparent,
           shadowColor: Colors.transparent,
           title: Text(LabelSignIn,style: boldHeading1.copyWith(color: onPrimaryColor)),
           centerTitle: true,
         ),
           body: SingleChildScrollView(
               child: SizedBox(
                 height: size.height-120,
                 width: double.infinity,
                 child: Padding(
                   padding: UIHelper.pagePaddingSmall.copyWith(bottom: 0),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Spacer(flex: 1,),
                       Text(LabelMobile,style: boldHeading3),
                       UIHelper.verticalSpaceSmall,
                       CustomTextField(controller: snumberController,keyboardType: TextInputType.number,),
                       if(model.phoneState==false)Text(labelPhoneE, style: TextStyle(color: errorMessage),),

                       UIHelper.verticalSpaceMedium,
                       Text(LabelPassword,style: boldHeading3),
                       UIHelper.verticalSpaceSmall,
                       CustomTextField(controller: spasswordController, showPassword: true,),
                       if(model.passState==false)Text(labelPasswordE, style: TextStyle(color: errorMessage),),

                       UIHelper.verticalSpaceLarge,
                       Container(
                         width: double.infinity,
                         height: 50,
                         child:
                         model.busy?
                         Center(child: CircularProgressIndicator(),) :
                         PrimaryButton(
                           text: Text(LabelSignIn,style: buttonTextStyle,),
                           ontap:() async {
                             bool passAns=model.validatePassword(spasswordController.text);
                             bool mobilAns=model.validateMobileNumber(snumberController.text);
                             if(passAns && mobilAns){
                               //Send Data to a method inside Model Class to access Database
                               await model.signin( snumberController, spasswordController);
                               if(model.signedIdnUser.id==''){
                                 showToast("Invalid Username or Password");
                               }
                               else {
                                 Navigator.push(context, new MaterialPageRoute(
                                     builder: (context) => new VerifyCodeView(
                                       signInUser: model.signedIdnUser,
                                     ))
                                 );
                               }
                             }
                           } ,
                         ),
                       ),
                       UIHelper.verticalSpaceMedium,
                       Row(
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
                       UIHelper.verticalSpaceSmall,
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


