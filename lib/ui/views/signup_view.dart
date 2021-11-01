import 'package:bluetaxiapp/ui/views/base_widget.dart';
import 'package:bluetaxiapp/ui/widgets/my_text_field.dart';
import 'package:bluetaxiapp/viewmodels/views/signup_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class SignUpView extends StatelessWidget {
   SignUpView({Key key}) : super(key: key);
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BaseWidget<SignUpViewModel>(
      model: SignUpViewModel(repo: Provider.of(context)),
      builder: (context, model, child) => child,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          title: Text("Sign up",style: TextStyle(fontSize:20,color: Colors.black )),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(right:36, left: 36, bottom: 20 ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MediaQuery.of(context).orientation==Orientation.landscape?SizedBox(height: 0,):SizedBox(height: 180,),
                Text("NAME",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                SizedBox(height: 7,),
                MyTextField(controller: nameController),
                SizedBox(height: 16,),
                Text("EMAIL",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                SizedBox(height: 7,),
                MyTextField(controller: emailController),
                SizedBox(height: 16,),
                Text("PASSWORD",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                SizedBox(height: 7,),
                MyTextField(controller: passwordController,showPassword: true,),
                SizedBox(height: 50,),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Color(0xff1152FD)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Color(0xff1152FD),width: 0.5)
                            )
                        )
                    ),
                    child: Text("Sign Up",style: TextStyle(fontSize: 15),),
                    onPressed: (){

                    },
                  ),
                ),
                SizedBox(height: 200,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?", style: TextStyle(color: Colors.grey, fontFamily: 'intel',),),
                    InkWell(
                      onTap: (){},
                      child: Text(
                        " SignUp", style: TextStyle(color: Color(0xff1152FD), ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


