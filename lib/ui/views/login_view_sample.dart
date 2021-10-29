import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bluetaxiapp/constants/app_contstants.dart';
import 'package:bluetaxiapp/viewmodels/views/login_view_model_sample.dart';
import 'package:bluetaxiapp/ui/shared/app_colors.dart';
import 'package:bluetaxiapp/ui/widgets/login_header_sample.dart';

import 'base_widget.dart';

class LoginViewSample extends StatefulWidget {
  @override
  _LoginViewSampleState createState() => _LoginViewSampleState();
}

class _LoginViewSampleState extends State<LoginViewSample> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseWidget<LoginViewModelSample>(
      model: LoginViewModelSample(authRepository: Provider.of(context)),
      child: LoginHeaderSample(controller: _controller),
      builder: (context, model, child) => Scaffold(
          backgroundColor: backgroundColor,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              child,
              model.busy
                  ? CircularProgressIndicator()
                  : FlatButton(
                      color: Colors.white,
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () async {
                        var loginSuccess = await model.login(_controller.text);
                        if (loginSuccess) {
                          Navigator.pushNamed(context, RoutePaths.Home);
                        }
                      },
                    )
            ],
          )),
    );
  }
}
