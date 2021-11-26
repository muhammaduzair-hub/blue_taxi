import 'package:bluetaxiapp/constants/strings.dart';
import 'package:bluetaxiapp/data/model/card_model.dart';
import 'package:bluetaxiapp/ui/shared/app_colors.dart';
import 'package:bluetaxiapp/ui/shared/text_styles.dart';
import 'package:bluetaxiapp/ui/shared/ui_helpers.dart';
import 'package:bluetaxiapp/ui/views/base_widget.dart';
import 'package:bluetaxiapp/ui/widgets/custom_text_field.dart';
import 'package:bluetaxiapp/ui/widgets/leading_back_button.dart';
import 'package:bluetaxiapp/ui/widgets/primary_button.dart';
import 'package:bluetaxiapp/viewmodels/views/add_card_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCardView extends StatelessWidget {
  const AddCardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<AddCardViewModel>(
        model: AddCardViewModel(repo: Provider.of(context)),
        builder: (context, model, child) =>  SafeArea(
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              shadowColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              leading: LeadindBackButton(
                ontap: (){Navigator.pop(context);},
                icon: AssetImage('asset/icons/nav btn.png'),
              ),
              title: Text(LabelAddCard,style: heading1.copyWith(color:onPrimaryColor ) ,),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: UIHelper.pagePaddingSmall,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(LabelCardNumber, style: boldHeading3,),
                    UIHelper.verticalSpaceSmall,
                    CustomTextField(controller: model.cardNumberController,),

                    UIHelper.verticalSpaceMedium,

                    Text(LabelCardHolderName, style: boldHeading3,),
                    UIHelper.verticalSpaceSmall,
                    CustomTextField(controller: model.cardHolderController,),

                    UIHelper.verticalSpaceMedium,

                    Text(LabelExpDate, style: boldHeading3,),
                    UIHelper.verticalSpaceSmall,
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(child: CustomTextField(controller: model.expMonthController,)),
                        UIHelper.horizontalSpaceSmall,
                        Flexible(child: CustomTextField(controller: model.expYearController,)),
                      ],
                    ),
                    UIHelper.verticalSpaceLarge,
                    Container(
                      width: double.infinity,
                      child: PrimaryButton(
                        text: Text(LabelAddCard),
                        ontap: ()async {
                          await model.addCard();
                          // Navigator.of(context).pop();
                          List<CardModel> cards=await model.getcards();
                          Navigator.pop(context, cards);
                        },
                      ),
                    )

                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }
}
