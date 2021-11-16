import 'package:bluetaxiapp/constants/strings.dart';
import 'package:bluetaxiapp/ui/shared/app_colors.dart';
import 'package:bluetaxiapp/ui/shared/text_styles.dart';
import 'package:bluetaxiapp/ui/shared/ui_helpers.dart';
import 'package:bluetaxiapp/ui/views/my_card_view.dart';
import 'package:bluetaxiapp/ui/views/my_profile_view.dart';
import 'package:bluetaxiapp/ui/views/signin_signup_view.dart';
import 'package:flutter/material.dart';

class UserMenuView extends StatelessWidget {
  UserMenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: onSecondaryColor,
      body: Column(
        children: [
          UIHelper.verticalSpaceMedium,
          Column(
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Color(0xffD5DDE0),
                  size: 28.8,
                ), onPressed: () {  },
              ),
              UIHelper.verticalSpaceSmall,
              Container(
                  height: 90.0,
                  width: 100.0,
                  child: Stack(children: <Widget>[
                    Positioned(
                      left: 5,
                      height: 80,
                      width: 80,
                      child: CircleAvatar(
                        radius: 40.0,
                        backgroundColor: Color(0xffD5DDE0),
                        backgroundImage:
                            AssetImage('asset/images/photo_user.png'),
                      ),
                    ),
                    Positioned(
                      bottom:65,
                      left: 71.0,
                      height: 35,
                      width: 25,
                      child: Container(
                        height: 30.0,
                        width: 30.0,
                        decoration: BoxDecoration(
                          color: onSecondaryColor,
                            borderRadius: BorderRadius.circular(15.0)
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.edit_outlined),
                          color: onPrimaryColor,
                          onPressed: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => new MyProfileView()));
                          },
                        ),
                      ),
                    )
                  ])),
              UIHelper.verticalSpaceSmall,
              Text(
                "Carson",
                style: boldHeading2.copyWith(color: userNameText),
              ),
              UIHelper.verticalSpaceSmall,
              Text(
                "carson@mail.com",
                style: heading2.copyWith(
                    color: onPrimaryColor2, fontWeight: FontWeight.w400),
              )
            ],
          ),
          UIHelper.verticalSpaceLarge,
          SizedBox(
            height: 390,
            child: GridView.count(
              padding: const EdgeInsets.all(21),
              crossAxisSpacing: 16,
              mainAxisSpacing: 14,
              crossAxisCount: 2,
              //scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: onSecondaryColor,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: shadow,
                        blurRadius: 5.0,
                        offset: Offset(4, 3.0),
                      ),
                    ],
                  ),
                  width: 148.0,
                  height: 120.0,
                  child: GestureDetector(
                    onTap: () {}, // handle your image tap here
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(28, 55, 28, 40),
                      //padding: const EdgeInsets.all(28.0),
                      child: Column(
                        children: [
                          Image.asset(
                            'asset/images/ic_history.png',
                            height: 36,
                            width: 36,
                            fit: BoxFit.cover,
                          ),
                          UIHelper.verticalSpaceSmall,
                          Text(
                            MenuRideHistory,
                            style: boldHeading2.copyWith(
                              color: userNameText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: onSecondaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: shadow,
                        blurRadius: 5.0,
                        offset: Offset(-4, 3.0),
                      ),
                    ],
                  ),
                  width: 148.0,
                  height: 120.0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MyCardView(),));
                    }, // handle your image tap here
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(28, 55, 28, 40),
                      child: Column(
                        children: [
                          Image.asset(
                            'asset/images/ic_payment.png',
                            height: 36,
                            width: 36,
                            fit: BoxFit.cover,
                          ),
                          UIHelper.verticalSpaceSmall,
                          Text(
                            MenuPayment,
                            style: boldHeading2.copyWith(
                              color: userNameText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: onSecondaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: shadow,
                        blurRadius: 5.0,
                        offset: Offset(3.0, -4),
                      ),
                    ],
                  ),
                  width: 148.0,
                  height: 120.0,
                  child: GestureDetector(
                    onTap: () {}, // handle your image tap here
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(28, 55, 28, 40),
                      child: Column(
                        children: [
                          Image.asset(
                            'asset/images/ic_promo.png',
                            height: 36,
                            width: 36,
                            fit: BoxFit.cover,
                          ),
                          UIHelper.verticalSpaceSmall,
                          Text(
                            MenuPromocode,
                            style: boldHeading2.copyWith(
                              color: userNameText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: onSecondaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: shadow,
                        blurRadius: 5.0,
                        offset: Offset(-4, -3.0),
                      ),
                    ],
                  ),
                  width: 148.0,
                  height: 120.0,
                  child: GestureDetector(
                    onTap: () {}, // handle your image tap here
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(28, 55, 28, 40),
                      child: Column(
                        children: [
                          Image.asset(
                            'asset/images/ic_support.png',
                            height: 36,
                            width: 36,
                            fit: BoxFit.cover,
                          ),
                          UIHelper.verticalSpaceSmall,
                          Text(
                            MenuSupport,
                            style: boldHeading2.copyWith(
                              color: userNameText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          UIHelper.verticalSpaceMedium,
          FloatingActionButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.clear,
              color: onPrimaryColor,
              size: 22,
            ),
            backgroundColor: onSecondaryColor,
            elevation: 5.0,
          )
        ],
      ),
    );
  }
}
