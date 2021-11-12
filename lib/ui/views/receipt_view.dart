import 'package:bluetaxiapp/ui/shared/app_colors.dart';
import 'package:bluetaxiapp/ui/shared/text_styles.dart';
import 'package:bluetaxiapp/ui/shared/ui_helpers.dart';
import 'package:bluetaxiapp/ui/views/base_widget.dart';
import 'package:bluetaxiapp/ui/views/user_menu_view.dart';
import 'package:bluetaxiapp/ui/widgets/leading_back_button.dart';
import 'package:bluetaxiapp/ui/widgets/primary_button.dart';
import 'package:bluetaxiapp/viewmodels/views/receipt_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReceiptView extends StatelessWidget {
  ReceiptView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<ReceiptViewModel>(
        model: ReceiptViewModel(repo: Provider.of(context)),
        builder: (context, model, child) => SafeArea(
            child: model.busy
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Scaffold(
                    body: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LeadingBackButton(
                          radius: 30.0,
                          ontap: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => new UserMenuView()));
                          },
                          icon: AssetImage('asset/icons/nav_btn.png'),
                        ),
                        AlertDialog(
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      color: onSecondaryColor,
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Image(
                                        image: AssetImage(
                                            'asset/icons/ic_success.png')),
                                  ),
                                ),
                                UIHelper.verticalSpaceMedium,
                                Center(
                                    child: Text(
                                  'Your Trip has ended',
                                  style: buttonTextStyle.copyWith(
                                      fontWeight: FontWeight.w700),
                                )),
                                UIHelper.verticalSpaceMedium,
                                Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    border: Border.all(
                                      color: Color(0xffD5DDE0),
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: <Widget>[
                                            SizedBox(height: 2.0),
                                            Container(
                                              width: 40.0,
                                              child: Text(
                                                '11:24',
                                                style: heading3.copyWith(
                                                    color: onPrimaryColor2,
                                                    fontWeight: FontWeight.w400),
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                            SizedBox(height:12.0),
                                            UIHelper.verticalSpaceMedium,
                                            Container(
                                              width: 40.0,
                                              child: Text(
                                                '11:38',
                                                style: heading3.copyWith(
                                                    color: onPrimaryColor2,
                                                    fontWeight: FontWeight.w400),
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Image(
                                            image: AssetImage(
                                                'asset/icons/ic_route.png')),
                                        Column(
                                          children: <Widget>[
                                            Container(
                                              width: 175.0,
                                              child: Text(
                                                '1, Thrale Street, London, SE19HW, UK',
                                                style: heading2.copyWith(fontWeight: FontWeight.w400),
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                            UIHelper.verticalSpaceSmall,
                                            Container(
                                              width: 175.0,
                                              child: Text(
                                                'Ealing Broadway Shopping Centre, London, W55JY',
                                                style: heading2.copyWith(fontWeight: FontWeight.w400),
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                UIHelper.verticalSpaceSmall,
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    border: Border.all(
                                      color: Color(0xffD5DDE0),
                                      width: 1.0,
                                    ),
                                    color: Colors.grey.shade100,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 17.0, vertical: 26.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Image(
                                            image: AssetImage(
                                                'asset/icons/shape.png')),
                                        Text('**** 8295'),
                                        Text('\$763'),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(21.0),
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            child: PrimaryButton(
                                text: Text(
                                  "OK",
                                  style: buttonTextStyle,
                                ),
                                ontap: () {
                                  //Move back to First Page
                                }),
                          ),
                        ),
                      ],
                    ),
                  ))));
  }
}
