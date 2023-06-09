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
                    Container(
                      height: 60,
                      child: CustomTextField(
                        maxLength: 16,
                        controller: model.cardNumberController,
                        keyboardType: TextInputType.number,
                      ),
                    ),

                    if(model.cardValidator==false)Text(LabelLenghtMustBeSixteen,style:TextStyle(color: errorMessage),),

                    UIHelper.verticalSpaceMedium,

                    Text(LabelCardHolderName, style: boldHeading3,),
                    UIHelper.verticalSpaceSmall,
                    Container(
                      height: 40,
                        child: CustomTextField(controller: model.cardHolderController,)),
                    if(model.holderValidator==false)Text(LabelInvalidName,style:TextStyle(color: errorMessage),),

                    UIHelper.verticalSpaceMedium,

                    Text(LabelExpDate, style: boldHeading3,),
                    UIHelper.verticalSpaceSmall,
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: (){model.monthPicker(context);},
                            child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: Color(0xffD5DDE0)
                                  )
                                ),
                              child: Center(child: Text(model.selectedDate!=null ? model.selectedDate!.month.toString() : ""),)
                            ),
                          ),
                        ),
                        UIHelper.horizontalSpaceSmall,
                       Expanded(
                         child:  InkWell(
                           onTap: (){model.monthPicker(context);},
                           child: Container(
                             height: 40,
                             decoration: BoxDecoration(
                                 color: Colors.grey.shade100,
                                 borderRadius: BorderRadius.circular(15),
                                 border: Border.all(
                                     color: Color(0xffD5DDE0)
                                 )
                             ),
                             child: Center(child: Text( model.selectedDate!=null ? model.selectedDate!.year.toString() : "")),
                           ),
                         )
                       )
                      ],
                    ),
                    UIHelper.verticalSpaceLarge,
                    Container(
                      width: double.infinity,
                      child: PrimaryButton(
                        text: Text(LabelAddCard),
                        ontap: ()async {
                          await model.addCard(context);
                          // Navigator.of(context).pop();

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
