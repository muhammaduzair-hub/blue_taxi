
import 'package:bluetaxiapp/ui/views/signin_signup_view.dart';
import 'package:bluetaxiapp/ui/views/user_menu_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bluetaxiapp/constants/app_contstants.dart';
import 'package:bluetaxiapp/data/model/post_sample.dart';
import 'package:bluetaxiapp/ui/views/home_view_sample.dart';
import 'package:bluetaxiapp/ui/views/login_view_sample.dart';
import 'package:bluetaxiapp/ui/views/post_view_sample.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.Home:
        return MaterialPageRoute(builder: (_) => HomeViewSample());
      case RoutePaths.Login:
        return MaterialPageRoute(builder: (_) => LoginViewSample());
      case RoutePaths.Signin:
        return MaterialPageRoute(builder: (_) => SignInSignUpView());
      case RoutePaths.UserMenu:
        return MaterialPageRoute(builder: (_) => UserMenuView());
      case RoutePaths.Post:
        var post = settings.arguments as PostSample;
        return MaterialPageRoute(builder: (_) => PostViewSample(post: post));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
