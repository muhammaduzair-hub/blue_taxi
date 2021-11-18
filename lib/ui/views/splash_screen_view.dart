import 'package:bluetaxiapp/ui/shared/globle_objects.dart';
import 'package:bluetaxiapp/ui/shared/text_styles.dart';
import 'package:bluetaxiapp/ui/views/base_widget.dart';
import 'package:bluetaxiapp/ui/views/booking_view.dart';
import 'package:bluetaxiapp/ui/views/signin_signup_view.dart';
import 'package:bluetaxiapp/viewmodels/views/splash_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splash_screen_view/SplashScreenView.dart';


class MySplashScreenView extends StatelessWidget {
  const MySplashScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<SplashScreenViewModel>(
        model: SplashScreenViewModel(repo: Provider.of(context)),
        builder: (context, model, child) => SplashScreenView(
          navigateRoute: model.nextRoute,
          duration: 4000,
          backgroundColor: Colors.blue,
          text: "Blue\nTaxi",
          textStyle: boldHeading1.copyWith(color: Colors.white),
        ),
    );
  }
}

