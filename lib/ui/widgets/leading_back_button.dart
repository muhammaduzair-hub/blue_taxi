import 'package:bluetaxiapp/ui/shared/app_colors.dart';
import 'package:flutter/material.dart';

class LeadindBackButton extends StatelessWidget {
   LeadindBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        Navigator.pop(context);
      },
      elevation: 6.0,
      fillColor: Colors.white,
      child: Icon(
        Icons.arrow_back_ios_outlined,
        color: onPrimaryColor,
        size: 17.0,

      ),
      padding: EdgeInsets.all(15.0),
      shape: CircleBorder(),
    );
  }
}

class LeadingBackButton extends StatelessWidget {
  LeadingBackButton({Key? key,required this.icon,required this.ontap, required this.radius}) : super(key: key);
  final AssetImage icon;
  final VoidCallback ontap;
  final double radius;

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: ontap,
      child: CircleAvatar(
        radius: 30,
        backgroundImage: icon,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}


class NavButton extends StatelessWidget {
  NavButton({Key? key,required this.icon,required this.ontap}) : super(key: key);
  final AssetImage icon;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: ontap,
      child: CircleAvatar(
        radius: 40,
        backgroundImage: icon,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}