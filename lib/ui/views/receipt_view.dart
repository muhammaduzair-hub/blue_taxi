import 'package:bluetaxiapp/ui/shared/app_colors.dart';
import 'package:bluetaxiapp/ui/shared/globle_objects.dart';
import 'package:bluetaxiapp/ui/shared/text_styles.dart';
import 'package:bluetaxiapp/ui/views/base_widget.dart';
import 'package:bluetaxiapp/ui/views/user_menu_view.dart';
import 'package:bluetaxiapp/ui/widgets/responsive_ui_widgets.dart';
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
             child: Scaffold(
                    body: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //NAV BUTTON
                        Padding(
                          padding: smallPadding,
                          child: LeadingBackButton(
                            ontap: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => new UserMenuPageView()));
                            },
                            image: AssetImage('asset/icons/navigation_button.png'),
                          ),
                        ),

                        model.busy ? Center(child: CircularProgressIndicator(),):


                        Padding(
                          padding: smallPadding,
                          child: Container(
                            decoration: BoxDecoration(
                                color: onSecondaryColor,

                                //color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(1,1),
                                      color: Colors.grey.withOpacity(0.4), spreadRadius: 3, blurRadius: 8)
                                ]
                            ),
                            child: ListBody(
                              children: <Widget>[
                                Padding(
                                  padding: smallPadding.copyWith(bottom:0.0),
                                  child: Container(
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
                                ),
                                Padding(
                                  padding: smallPadding.copyWith(bottom:0.0),
                                  child: Center(
                                      child: Text(
                                    'Your Trip has ended',
                                    style: buttonTextStyle.copyWith(
                                        fontWeight: FontWeight.w700),
                                  )),
                                ),


                                Padding(
                                  padding:smallPadding.copyWith(bottom:height*0.005),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                      border: Border.all(
                                        color: Color(0xffD5DDE0),
                                      ),
                                    ),
                                    child: IntrinsicHeight(
                                      child: Padding(
                                        padding: smallPadding,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Container(
                                                  child: Text(
                                                    "${model.requestDataModel.createDate!.hour}:${model.requestDataModel.createDate!.minute}",
                                                    style: heading2.copyWith(
                                                        fontWeight: FontWeight.w400,
                                                        color: onPrimaryColor2),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                                SizedBox(height: width*1/10,),
                                                Container(
                                                  child: Text(
                                                    "${model.endingTime.hour}:${model.endingTime.minute}",
                                                    style: heading2.copyWith(
                                                        fontWeight: FontWeight.w400,
                                                        color: onPrimaryColor2),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                              child: Image(
                                                  image: AssetImage('asset/icons/ic_route.png')),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: <Widget>[
                                                  Container(
                                                    child: Text(
                                                      model.requestDataModel.address!.from!.place_name.toString(),
                                                      style: heading2.copyWith(
                                                          fontWeight: FontWeight.w400),
                                                      textAlign: TextAlign.start,
                                                    ),
                                                  ),
                                                  SizedBox(height: width*1/20,),
                                                  Container(
                                                    child: Text(
                                                      model.requestDataModel.address!.to!.place_name.toString(),
                                                      style: heading2.copyWith(
                                                          fontWeight: FontWeight.w400),
                                                      textAlign: TextAlign.start,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                //CASH CARD
                                Padding(
                                  padding:smallPadding.copyWith(top:0.0),
                                  child: Container(
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
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Image(image: model.requestDataModel.payment!.type =="Cash"?AssetImage("asset/icons/ic_cash.png"): AssetImage('asset/icons/shape.png')),
                                              Text(model.requestDataModel.payment!.card_no.toString()),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(right: 6.0),
                                            child: Text('\$${model.requestDataModel.expectedBill}'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        //OK BUTTON
                        if(model.busy==false)Padding(
                          padding: smallPadding,
                          child: SizedBox(
                            width: double.infinity,
                            height: height * 0.06,
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
                  ))));
  }
}



