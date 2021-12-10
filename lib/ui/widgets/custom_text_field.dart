import 'package:bluetaxiapp/ui/shared/app_colors.dart';
import 'package:bluetaxiapp/ui/views/base_widget.dart';
import 'package:bluetaxiapp/viewmodels/widgets/custom_text_field_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final bool showPassword ;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final TextInputType keyboardType;

  CustomTextField({this.controller, this.showPassword = false, this.minLines, this.maxLines, this.keyboardType = TextInputType.text, this.maxLength});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      child:
        showPassword?
            BaseWidget<CustomTextFieldViewModel>(
              model: CustomTextFieldViewModel(),
              builder: (context, model, child) => TextField(
                maxLength: maxLength,
                  textAlignVertical: TextAlignVertical.center,
                  obscureText: model.obscureText,
                  decoration: InputDecoration(
                    focusedBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Color(0xffD5DDE0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Color(0xffD5DDE0)),
                    ),
                    suffixIcon: IconButton(
                      icon:  Icon(model.obscureText?Icons.visibility:Icons.visibility_off,size: 19,),
                      onPressed: (){
                        model.switchState();
                      },
                    ),
                    fillColor:Colors.grey.shade100,//Color(0xffF7F8F9),//Colors.grey.shade200,
                    filled: true,
                  ),
                  controller:controller
              ),
            )
            :
        TextField(
          maxLength: maxLength,
          keyboardType: keyboardType,
            decoration: InputDecoration(
              focusedBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Color(0xffD5DDE0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Color(0xffD5DDE0)),
              ),
              fillColor:Colors.grey.shade100,//Color(0xffF7F8F9),//Colors.grey.shade200,
              filled: true,
            ),
            minLines: minLines??1,//Normal textInputField will be displayed
            maxLines: maxLines??1,// when user presses enter it will adapt to it
            controller:controller
        ),
    );
  }
}


class CustomTextFieldWithLading extends StatelessWidget {
  final TextEditingController controller;
  final bool showPassword ;
  final IconData preficIcon;

  CustomTextFieldWithLading({required this.controller, this.showPassword = false, required this.preficIcon,});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6),
      height: 44,
      child: TextField(
        obscureText: showPassword?true:false,
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
            prefixIcon:Icon(preficIcon,color: Colors.blue,) ,
            fillColor:onSecondaryColor,//Color(0xffF7F8F9),//Colors.grey.shade200,
            filled: true,
          ),


          controller:controller
      ),
    );
  }
}
