import 'package:bluetaxiapp/constants/strings.dart';
import 'package:bluetaxiapp/ui/shared/app_colors.dart';
import 'package:bluetaxiapp/ui/shared/text_styles.dart';
import 'package:bluetaxiapp/ui/shared/ui_helpers.dart';
import 'package:bluetaxiapp/ui/views/base_widget.dart';
import 'package:bluetaxiapp/ui/widgets/my_elevated_button.dart';
import 'package:bluetaxiapp/ui/widgets/my_text_field.dart';
import 'package:bluetaxiapp/viewmodels/views/signup_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class SignUpView extends StatelessWidget {
   SignUpView({Key key}) : super(key: key);
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
        Signup(context, size),
        Signup(context, size),
      ],
    );

  }

   Widget Signup(BuildContext context, Size size){
     return BaseWidget<SignUpViewModel>(
       model: SignUpViewModel(repo: Provider.of(context)),
       builder: (context, model, child) => Scaffold(
         appBar: AppBar(
           elevation: 0.0,
           backgroundColor: Colors.transparent,
           shadowColor: Colors.transparent,
           title: Text("Sign up",style: TextStyle(fontSize:20,color: Colors.black )),
           centerTitle: true,
         ),
         body: SingleChildScrollView(
             child: SizedBox(
               height: size.height-120,
               width: double.infinity,
               child: Padding(
                 padding: UIHelper.signInSignUpPagePadding,
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Spacer(),
                     Text(LabelName,style: boldThirteenPixelText),
                     UIHelper.verticalSpaceSmall,
                     MyTextField(
                       controller: nameController,
                     ),
                     UIHelper.verticalSpaceMedium,
                     Text(LabelEmail,style: boldThirteenPixelText),
                     UIHelper.verticalSpaceSmall,
                     MyTextField(controller: emailController),
                     UIHelper.verticalSpaceMedium,
                     Text(LabelMobile,style: boldThirteenPixelText),
                     UIHelper.verticalSpaceSmall,
                     MyTextField(controller: numberController,),
                     UIHelper.verticalSpaceMedium,
                     Text(LabelPassword,style: boldThirteenPixelText),
                     UIHelper.verticalSpaceSmall,
                     MyTextField(
                       controller: passwordController,
                       showPassword: true,
                     ),
                     UIHelper.verticalSpaceLarge,
                     Container(
                       width: double.infinity,
                       height: 50,
                       child: MyElevatedButton(
                         text: Text(LabelSignup,style: buttonTextStyle,),
                         ontap:(){
                           bool passAns=model.validatePassword(passwordController.text);
                           bool emailAns=model.validateEmail(emailController.text);
                           bool mobilAns=model.validateMobileNumber(numberController.text) ;
                           bool nameAns = model.validateName(nameController.text);
                           print("name:$nameAns\nemail:$emailAns\nmobile:$mobilAns\npassword:$passAns");
                         } ,
                       ),
                     ),
                     //SizedBox(height: 200,),
                     Spacer(flex: 2,),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Text(LabelAlreadyHaveAccount, style: normalThirteenPixelText.copyWith(color: greyTextColor)),
                         InkWell(
                           onTap: (){
                           },
                           child: Text(
                             LabelSignIn, style: normalFifteenPixelText.copyWith(color: linkTextColor ),
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
       child: Scaffold(),
     );
   }
}


