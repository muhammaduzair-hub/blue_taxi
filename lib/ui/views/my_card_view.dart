import 'package:bluetaxiapp/constants/strings.dart';
import 'package:bluetaxiapp/ui/shared/app_colors.dart';
import 'package:bluetaxiapp/ui/shared/text_styles.dart';
import 'package:bluetaxiapp/ui/shared/ui_helpers.dart';
import 'package:bluetaxiapp/ui/views/add_card_view.dart';
import 'package:bluetaxiapp/ui/views/base_widget.dart';
import 'package:bluetaxiapp/ui/widgets/leading_back_button.dart';
import 'package:bluetaxiapp/ui/widgets/primary_button.dart';
import 'package:bluetaxiapp/viewmodels/views/my_card_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class MyCardView extends StatelessWidget {
  const MyCardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<MyCardViewModel>(
      model: MyCardViewModel(repo: Provider.of(context)),
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            leading: LeadindBackButton(
              ontap: (){Navigator.pop(context);},
              icon: AssetImage('asset/icons/nav btn.png'),
            ),
            title: Text(LabelMyCards,style: heading1.copyWith(color:onPrimaryColor ) ,),
            centerTitle: true,
          ),
          body: Padding(
            padding: UIHelper.pagePaddingSmall,
            child:
            model.busy? Center(child: CircularProgressIndicator(),):
            SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(LabelCards, style: boldHeading3,),
                  UIHelper.verticalSpaceSmall,
                  Container(
                    child: ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: model.myCards.length,
                      separatorBuilder: (context, index) => UIHelper.verticalSpaceSmall,
                      itemBuilder: (context, index) =>
                          paymentOptionListTile(
                              leadingImage: model.myCards[index].leadingImage,
                              text: model.myCards[index].cardNumber,
                          ),
                    ),
                  ),
                  UIHelper.verticalSpaceSmall,
                  Text(LabelCash, style: boldHeading3,),
                  UIHelper.verticalSpaceSmall,
                  paymentOptionListTile(
                      leadingImage: AssetImage("asset/icons/ic_cash.png"),
                      text: LabelCash,
                  ),
                  UIHelper.verticalSpaceLarge,
                  Container(
                    width: double.infinity,
                    child: PrimaryButton(
                      ontap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddCardView(),));
                      },
                      text: Text(LabelAddCard,style: heading2.copyWith(color: onSecondaryColor),) ,
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


  Widget paymentOptionListTile({required AssetImage leadingImage, required String text, }) {
    return  Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: onPrimaryColor.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(3,2)
            )
          ]
      ),
      child: ListTile(
        leading: Image(image: leadingImage),
        title: Text("$text"),
        //trailing: Image(image: trailingImage,),
      ),
    );
  }
}
