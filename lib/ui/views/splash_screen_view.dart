import 'package:bluetaxiapp/ui/shared/globle_objects.dart';
import 'package:bluetaxiapp/ui/views/base_widget.dart';
import 'package:bluetaxiapp/ui/views/booking_view.dart';
import 'package:bluetaxiapp/ui/views/signin_signup_view.dart';
import 'package:bluetaxiapp/viewmodels/views/splash_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SplashScreenView extends StatelessWidget {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<SplashScreenViewModel>(
        model: SplashScreenViewModel(repo: Provider.of(context),con: context),
        builder: (context, model, child) => Center(child: CircularProgressIndicator(),)
    );
  }
}

