import 'package:bluetaxiapp/constants/strings.dart';
import 'package:bluetaxiapp/ui/shared/app_colors.dart';
import 'package:bluetaxiapp/ui/shared/text_styles.dart';
import 'package:bluetaxiapp/ui/shared/ui_helpers.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class TermsConditionView extends StatefulWidget {
  TermsConditionView({Key? key}) : super(key: key);

  @override
  State<TermsConditionView> createState() => _TermsConditionViewState();
}

class _TermsConditionViewState extends State<TermsConditionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: onSecondaryColor,
        elevation: 0.0,
        leading: CircleAvatar(
          radius: 20.0,
          backgroundColor: Colors.transparent,
          child: RawMaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            elevation: 4.0,
            fillColor: Colors.white,
            child: Icon(
              Icons.arrow_back_ios_outlined,
              color: onPrimaryColor,
              size: 17.0,
            ),
            padding: EdgeInsets.all(15.0),
            shape: CircleBorder(),
          ),
        ),
      ),
      backgroundColor: onSecondaryColor,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              UIHelper.verticalSpaceMedium,
              Container(
                alignment: AlignmentDirectional.center,
                width: double.infinity,
                child: Text(
                  terms_cond,
                  style: boldHeading1.copyWith(color: onPrimaryColor),
                ),
              ),
              UIHelper.verticalSpaceSmall,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 110.0),
                alignment: AlignmentDirectional.center,
                width: double.infinity,
                child: Text(
                  terms_cond2,
                  textAlign: TextAlign.center,
                  style: boldHeading3.copyWith(color: onPrimaryColor),
                ),
              ),
              UIHelper.verticalSpaceLarge,
              Padding(
                padding: const EdgeInsets.only(left: 14.0),
                child: Text(
                  terms_code3 + ":",
                  textAlign: TextAlign.center,
                  style: heading2.copyWith(color: onPrimaryColor),
                ),
              ),
              UIHelper.verticalSpaceMedium,
              Flexible(
                child: Container(
                  padding: EdgeInsets.all(5),
                  height: 400,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Text(
                      terms_code4,
                      textAlign: TextAlign.left,
                      style: heading2.copyWith(
                        color: onPrimaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
