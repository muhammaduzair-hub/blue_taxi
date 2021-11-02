//import 'package:bluetaxiapp/ui/widgets/signin_header.dart';
import 'package:bluetaxiapp/constants/app_contstants.dart';
import 'package:bluetaxiapp/viewmodels/views/signin_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:bluetaxiapp/constants/app_contstants.dart';
import 'package:bluetaxiapp/ui/shared/app_colors.dart';
//import 'package:bluetaxiapp/ui/widgets/login_header_sample.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'base_widget.dart';

class SigninView extends StatefulWidget {
  @override
  _SigninViewState createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<SigninViewModel>(
      model: SigninViewModel(authRepository: Provider.of(context)),
      builder: (context, model, child) => child,
      child: Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
            "Sign in",
            style: TextStyle(
              fontFamily: "Inter",
              fontSize: 20.0,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          )),
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        backgroundColor: backgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(36.0),
          child: SingleChildScrollView(
            child: Column(
              // EdgeInsets.all(10.0),
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  " EMAIL",
                  style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 13.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 7.0,
                ),
                SizedBox(
                  height: 44,
                  child: TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100, //Color(0xffD5DDE0),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(width: 0.0, color:Colors.grey.shade100 ),
                        ),
                      )),
                ),
                SizedBox(
                  height: 13.0,
                ),
                Text(
                  " PASSWORD",
                  style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 13.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 7.0,
                ),
                SizedBox(
                  height: 44,
                  child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100, //Color(0xffD5DDE0),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(width: 0.0,  color:Colors.grey.shade100),
                        ),
                        suffixIcon: Icon(Icons.visibility_off,  size: 18.0, color: Color(0xff97ADB6)),
                      )),
                ),
                SizedBox(
                  height: 50.0,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(350, 60),
                      primary: Color(0xff1152FD),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15), // <-- Radius
                      ),
                    ),
                    onPressed: () {
                      //Send to Home Page
                      Navigator.pushNamed(
                        context,
                        RoutePaths.Verify,
                        // arguments: model.posts[index],
                      );

                    },
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: "Inter",
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    )),
                SizedBox(
                  height: 70.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: 110.0,
                      height: 2,
                      color: Color(0xffD5DDE0),
                    ),
                    Text(
                      " OR SIGN IN WITH ",
                      style: TextStyle(
                          fontSize: 13.0,
                          fontFamily: "Inter",
                          color: Color(0xff3E4958),
                          fontWeight: FontWeight.w700
                      ),
                    ),
                    Container(
                      width: 110.0,
                      height: 2,
                      color: Color(0xffD5DDE0),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.0,
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
                SizedBox(
                  height: 90.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      " Don't have an account? ",
                      style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: "Inter",
                          color: Color(0xff97ADB6),
                          fontWeight: FontWeight.w400),
                    ),
                    GestureDetector(
                      onTap: (){
                        //Send to Sign Up Page
                      },
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 15.0,
                            fontFamily: "Inter",
                            color: Color(0xff1152FD),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
