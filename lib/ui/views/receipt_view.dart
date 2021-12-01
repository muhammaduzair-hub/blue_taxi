import 'package:bluetaxiapp/data/model/request_model.dart';
import 'package:bluetaxiapp/ui/shared/app_colors.dart';
import 'package:bluetaxiapp/ui/shared/text_styles.dart';
import 'package:bluetaxiapp/ui/shared/ui_helpers.dart';
import 'package:bluetaxiapp/ui/views/adress_selection_view.dart';
import 'package:bluetaxiapp/ui/views/base_widget.dart';
import 'package:bluetaxiapp/ui/views/user_menu_view.dart';
import 'package:bluetaxiapp/ui/widgets/leading_back_button.dart';
import 'package:bluetaxiapp/ui/widgets/primary_button.dart';
import 'package:bluetaxiapp/viewmodels/views/receipt_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReceiptView extends StatelessWidget {
  final String requestId;

  ReceiptView({Key? key,required this.requestId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<ReceiptViewModel>(
        model: ReceiptViewModel(repo: Provider.of(context), requestId: requestId),
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
                                IntrinsicHeight(
                                  child: Container(
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
                                      child: IntrinsicHeight(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              children: <Widget>[
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
                                                Spacer(),
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
                                            Expanded(
                                              child: Image(
                                                  image: AssetImage(
                                                      'asset/icons/ic_route.png')),
                                            ),
                                            Column(
                                            children: <Widget>[
                                              Container(
                                                width: 175.0,
                                                child: Text(
                                                  model.requestDataModel.address!.from!.place_name.toString(),
                                                  style: heading2.copyWith(fontWeight: FontWeight.w400),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                              UIHelper.verticalSpaceSmall,
                                              Container(
                                                width: 175.0,
                                                child: Text(
                                                  model.requestDataModel.address!.to!.place_name.toString(),
                                                  style: heading2.copyWith(fontWeight: FontWeight.w400),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                            ],
                                            )
                                          ],
                                        ),
                                      ),
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
                                        Text(model.requestDataModel.payment!.card_no.toString()),
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
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.pop(context);

                                  // Navigator.push(
                                  //     context,
                                  //     new MaterialPageRoute(
                                  //         builder: (context) => new AdressSelectionView()));
                                }),
                          ),
                        ),
                      ],
                    ),
                  ))));
  }
}
