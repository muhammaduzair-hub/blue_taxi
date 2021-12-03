import 'package:bluetaxiapp/constants/strings.dart';
import 'package:bluetaxiapp/data/model/driver_model.dart';
import 'package:bluetaxiapp/ui/shared/app_colors.dart';
import 'package:bluetaxiapp/ui/shared/text_styles.dart';
import 'package:bluetaxiapp/ui/shared/ui_helpers.dart';
import 'package:bluetaxiapp/ui/views/base_widget.dart';
import 'package:bluetaxiapp/ui/widgets/leading_back_button.dart';
import 'package:bluetaxiapp/viewmodels/views/driver_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class DriverDetailView extends StatelessWidget {
  DriverModel? driverDocument;
  DriverDetailView({required this.driverDocument, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<DriverDetailViewModel>(
      model: DriverDetailViewModel(authRepository: Provider.of(context)),
      builder: (context, model, child) => SafeArea(
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              elevation: 0.0,
              leading: LeadindBackButton(ontap:(){Navigator.pop(context);},icon: AssetImage('asset/icons/nav btn.png') ,),
              centerTitle: true,
              title: Text(LabelDriverDetail, style: heading1.copyWith(color:onPrimaryColor),),
            ),
            body: Column(
              children: [
                UIHelper.verticalSpaceMedium,
                ListTile(
                  leading: CircleAvatar(backgroundImage: AssetImage('asset/images/jurica-koletic-317414-unsplash.png'),),
                  title: Text(driverDocument!.driverName ?? "Patrick",style: boldHeading2 ,),//Its name and come from model
                  subtitle: Text(driverDocument!.carName ?? "Mercedes Vito"),
                ),
                UIHelper.verticalSpaceMedium,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    profileContainer(AssetImage('asset/images/ic_rating.png',),driverDocument!.rating ?? "4.8"),
                    profileContainer(AssetImage('asset/images/ic_rating.png',),"126"),
                    profileContainer(AssetImage('asset/images/ic_calendar.png',),"2 years")
                  ],
                ),
                UIHelper.verticalSpaceMedium,
                Padding(
                  padding: UIHelper.pagePaddingSmall,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            color: secondaryColor2
                        )
                    ),
                    child: Column(
                      children: [
                        listTile(LabelMemberSince, "16.06.2017"),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Divider(height: 2,color: secondaryColor2,),
                        ),
                        listTile(LabelCarType, "Van"),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Divider(height: 2,color: secondaryColor2,),
                        ),
                        listTile(LabelPlateNumber, driverDocument!.carNumber?? "HS785K"),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Divider(height: 2,color: secondaryColor2,),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget profileContainer(AssetImage icon, String text){
    return Container(
      width: 90,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
              color: secondaryColor2
          )
      ),
      child: Column(
        children: [
          UIHelper.verticalSpaceSmall,
          CircleAvatar(backgroundImage: icon,backgroundColor: Colors.transparent,),
          UIHelper.verticalSpaceSmall,
          Text(text,)
        ],
      ),
    );
  }

  Widget listTile(String title, String subtitle){
    return ListTile(
      title: Text(title,style: heading3.copyWith(color: onPrimaryColor2,fontSize: 13),),
      subtitle: Text(subtitle,style: heading2.copyWith(color: onPrimaryColor),),
    );
  }
}
