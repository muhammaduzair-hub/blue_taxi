import 'package:bluetaxiapp/data/model/request_model.dart';
import 'package:bluetaxiapp/ui/shared/app_colors.dart';
import 'package:bluetaxiapp/ui/shared/text_styles.dart';
import 'package:bluetaxiapp/ui/shared/ui_helpers.dart';
import 'package:bluetaxiapp/ui/views/adress_selection_view.dart';
import 'package:intl/intl.dart';
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
    double size = MediaQuery.of(context).size.width;
    return BaseWidget<ReceiptViewModel>(
        model: ReceiptViewModel(repo: Provider.of(context), requestId: requestId),
        builder: (context, model, child) => SafeArea(
             child: Scaffold(
                    body: SingleChildScrollView(
                      child: Container(
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
                                      builder: (context) => new UserMenuPageView()));
                            },
                            icon: AssetImage('asset/icons/nav_btn.png'),
                          ),
                          model.busy ? Center(child: CircularProgressIndicator(),):
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
                                    child: IntrinsicHeight(
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
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 11.0, bottom: 40),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Container(
                                                            width: 40.0,
                                                            child: Text(
                                                              '${model.requestDataModel.createDate!.hour}:${model.requestDataModel.createDate!.minute}',
                                                              style: heading3.copyWith(
                                                                  color: onPrimaryColor2,
                                                                  fontWeight: FontWeight.w400),
                                                              textAlign: TextAlign.start,
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 40.0,
                                                            child: Text(
                                                              '${model.endingTime.hour}:${model.endingTime.minute}',
                                                              style: heading3.copyWith(
                                                                  color: onPrimaryColor2,
                                                                  fontWeight: FontWeight.w400),
                                                              textAlign: TextAlign.start,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 11.0, bottom: 40),
                                                      child: Column(
                                                        children: [
                                                          Image(image:
                                                              AssetImage('asset/icons/ellipse.png')),
                                                          UIHelper.verticalSpaceLeast,
                                                          Expanded(
                                                            child: Container(
                                                                      width: 1.0,
                                                                      color: Colors.black,
                                                                    ),
                                                          ),
                                                          UIHelper.verticalSpaceLeast,
                                                          Image(image:
                                                          AssetImage('asset/icons/triangle.png')),
                                                        ],
                                                      ),
                                                    ),
                                                    UIHelper.horizontalSpaceSmall,
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Container(
                                                            width: size*0.40,
                                                            child: Text(
                                                              model.requestDataModel.address!.from!.place_name.toString(),
                                                              style: heading2.copyWith(fontWeight: FontWeight.w400),
                                                              textAlign: TextAlign.start,
                                                            ),
                                                          ),
                                                        ),
                                                        UIHelper.verticalSpaceSmall,
                                                        Flexible(
                                                          child: Container(
                                                            width: size*0.40,
                                                            child: Text(
                                                              model.requestDataModel.address!.to!.place_name.toString(),
                                                              style: heading2.copyWith(fontWeight: FontWeight.w400),
                                                              textAlign: TextAlign.start,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),

                                              ],
                                            ),
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
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 5),
                                      height: 40,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Image(image: model.requestDataModel.payment!.type =="Cash"?AssetImage("asset/icons/ic_cash.png"): AssetImage('asset/icons/shape.png')),
                                              UIHelper.horizontalSpaceSmall,
                                              Text(model.requestDataModel.payment!.card_no.toString()),
                                            ],
                                          ),
                                          Text('\$${model.requestDataModel.expectedBill}'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if(model.busy==false)Padding(
                            padding: UIHelper.pagePaddingMedium.copyWith(bottom: MediaQuery.of(context).size.height * 0.015),
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
                                  }),
                            ),
                          ),
                        ],
                      ),
                  ),
                    ))));
  }
}
