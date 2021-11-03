import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool showPassword ;


  CustomTextField({this.controller, this.showPassword = false,});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      child: TextField(
        obscureText: false,//showPassword?true:false,
          decoration: InputDecoration(
            focusedBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Color(0xffD5DDE0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Color(0xffD5DDE0)),
            ),
            suffixIcon: !showPassword?null:
            IconButton(
              icon: Icon(Icons.visibility_off,size: 19,),
              onPressed: (){
              },
            ),
            fillColor:Colors.grey.shade100,//Color(0xffF7F8F9),//Colors.grey.shade200,
            filled: true,
          ),
          controller:controller
      ),
    );
  }
}