import 'package:bluetaxiapp/constants/app_contstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DemoView extends StatelessWidget {
  const DemoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("demo View"),),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){Navigator.pushNamed(context, RoutePaths.LoginSignup);}, child: Text(RoutePaths.LoginSignup)),
            ElevatedButton(onPressed: (){Navigator.pushNamed(context, RoutePaths.MyProfile);}, child: Text(RoutePaths.MyProfile))
          ],
        ),
      ),
    );
  }
}
