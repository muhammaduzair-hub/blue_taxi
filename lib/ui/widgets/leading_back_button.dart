import 'package:bluetaxiapp/ui/shared/app_colors.dart';
import 'package:flutter/material.dart';

class LeadindBackButton extends StatelessWidget {
   LeadindBackButton({Key key,@required this.icon,@required this.ontap}) : super(key: key);
   final AssetImage icon;
   final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    // return RawMaterialButton(
    //   onPressed: ontap,
    //   elevation: 6.0,
    //   fillColor: Colors.white,
    //   child: Icon(
    //     Icons.arrow_back_ios_outlined,
    //     color: onPrimaryColor,
    //     size: 17.0,
    //
    //   ),
    //   padding: EdgeInsets.all(15.0),
    //   shape: CircleBorder(),
    // );

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