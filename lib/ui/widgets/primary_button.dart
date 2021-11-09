import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final Text? text;
  final VoidCallback? ontap;

   PrimaryButton({Key? key, this.text,  this.ontap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xff1152FD)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(color: Color(0xff1152FD),width: 0.5)
          ),
        ),
      ),
      child: text,
      onPressed: ontap,
    );
  }
}
