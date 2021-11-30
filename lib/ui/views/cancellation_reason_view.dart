import 'package:bluetaxiapp/constants/strings.dart';
import 'package:bluetaxiapp/ui/shared/app_colors.dart';
import 'package:bluetaxiapp/ui/shared/globle_objects.dart';
import 'package:bluetaxiapp/ui/shared/text_styles.dart';
import 'package:bluetaxiapp/ui/shared/ui_helpers.dart';
import 'package:bluetaxiapp/ui/views/base_widget.dart';
import 'package:bluetaxiapp/ui/views/booking_view.dart';
import 'package:bluetaxiapp/ui/widgets/primary_button.dart';
import 'package:bluetaxiapp/viewmodels/views/arriving_view_model.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CancellationReasonView extends StatelessWidget {
  CancellationReasonView({Key? key}) : super(key: key);

  ArrivingSelectionViewModel? arrivingModel;


  @override
  Widget build(BuildContext context) {
    return BaseWidget<ArrivingSelectionViewModel>(
      model: ArrivingSelectionViewModel(requestId,repo: Provider.of(context),),
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
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
          body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                UIHelper.verticalSpaceXLarge,
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Container(
                    width: 220.0,
                    child: Text(
                      cancel_reason,
                      style: boldHeading1.copyWith(
                          color: onPrimaryColor),
                    ),
                  ),
                ),
                UIHelper.verticalSpaceLarge,

                ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildCheckListItems(index, model);
                    }),

                UIHelper.verticalSpaceLarge,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 21.0,),
                  width: double.infinity,
                  height: 50,
                  child: PrimaryButton(
                    text: Text(submit,style: buttonTextStyle,),
                    ontap:(){
                      model.switchState(EnumToString.convertToString(Status.Cancelled));
                      Navigator.push(context, new MaterialPageRoute(
                          builder: (context) => BookingView()));
                    },
                  ),
                ),
              ]),
        ),
      ),
    );
  }


  Widget _myRadioButton({required String title, required int value,Function(int?)? onChanged, required ArrivingSelectionViewModel model}) {
    return RadioListTile(
      value: value,
      onChanged: onChanged!,
      title: Text(title),
      groupValue: model.groupValue,
    );
  }

  Widget _buildCheckListItems(int index, ArrivingSelectionViewModel model) {
    return Column(
      //Via List Model
      children: <Widget>[
        _myRadioButton(
          title: cancel_r1,
          value: 0,
          onChanged: (newValue) => model.switchGroupValue(newValue!),
          model: model
        ),
        _myRadioButton(
          title: cancel_r2,
          value: 1,
          onChanged: (newValue) => model.switchGroupValue(newValue!),
            model: model
        ),
        _myRadioButton(
          title: cancel_r3,
          value: 2,
          onChanged: (newValue) => model.switchGroupValue(newValue!),
            model: model
        ),
        _myRadioButton(
          title: cancel_r4,
          value: 3,
          onChanged: (newValue) => model.switchGroupValue(newValue!),
            model: model
        ),
        _myRadioButton(
          title: cancel_r5,
          value: 4,
          onChanged: (newValue) => model.switchGroupValue(newValue!),
            model: model
        ),
      ],
    );
  }
}
