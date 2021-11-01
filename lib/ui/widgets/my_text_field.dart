import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool showPassword ;

  MyTextField({this.controller, this.showPassword = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      child: TextField(
        obscureText: showPassword?true:false,
          decoration: InputDecoration(
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
