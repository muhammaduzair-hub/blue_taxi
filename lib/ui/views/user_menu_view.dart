import 'package:bluetaxiapp/ui/shared/app_colors.dart';
import 'package:bluetaxiapp/ui/shared/globle_objects.dart';
import 'package:bluetaxiapp/ui/shared/text_styles.dart';
import 'package:bluetaxiapp/ui/views/my_card_view.dart';
import 'package:bluetaxiapp/ui/views/my_profile_view.dart';
import 'package:bluetaxiapp/ui/views/support_view.dart';
import 'package:bluetaxiapp/ui/views/trip_history_view.dart';
import 'package:bluetaxiapp/ui/widgets/responsive_ui_widgets.dart';
import 'package:flutter/material.dart';

class UserMenuPageView extends StatelessWidget {
  const UserMenuPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Container(
            height: height,
            child: Padding(
              padding: smallPadding,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                        image: AssetImage("asset/icons/arrow.png"),
                        ontap: () {
                          Navigator.pop(context);
                        }),
                    Container(height: height*0.5/20,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(70),
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.3),
                              )),
                          child: CustomImage(
                            ontap: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => new MyProfileView()));
                            },
                          ),
                        ),
                         Text(
                          signedINUser.name!,
                           style: boldHeading2.copyWith(color: userNameText),
                        ),
                        Text(
                          signedINUser.email!,
                          style: heading2.copyWith(color: onPrimaryColor2, fontWeight: FontWeight.w400),)
                      ],
                    ),
                    Container(height: height*0.5/20,),
                    GridView.count(
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      crossAxisCount: 2,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: <Widget>[
                        MenuButton(menuLabel: 'Ride History', image: 'asset/images/ic_history.png', dy: 3.0, dx: 3.0,
                            ontap: () async {
                              await Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => new RideHistoryView()));
                            },),
                        MenuButton(menuLabel: 'Payment', image: 'asset/images/ic_payment.png', dy: 3.0, dx: -3.0,
                          ontap: () async {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MyCardView(),));
                          },),

                          MenuButton(menuLabel: 'Support', image: 'asset/images/ic_promo.png', dy: -3.0, dx: 4.0,
                            ontap: () async {
                              await Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => new SupportView()));
                            },),
                          MenuButton(menuLabel: 'Maintenance', image: 'asset/images/ic_payment.png', dy: -3.0, dx: -4.0,
                            ontap: () async {
                              await Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => new RideHistoryView()));
                            },),
                        ],
                      ),
                    Container(height: height*0.2/20,),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(width * 1 / 3),
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.3),
                          )),
                      child: CustomImage(
                        radius: (MediaQuery.of(context).size.height + MediaQuery.of(context).size.width ) /40,
                        image: "asset/images/cross.png",
                        ontap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}