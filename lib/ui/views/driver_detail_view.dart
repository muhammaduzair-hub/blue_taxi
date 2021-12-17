import 'package:bluetaxiapp/constants/strings.dart';
import 'package:bluetaxiapp/data/model/driver_model.dart';
import 'package:bluetaxiapp/ui/shared/app_colors.dart';
import 'package:bluetaxiapp/ui/shared/globle_objects.dart';
import 'package:bluetaxiapp/ui/shared/text_styles.dart';
import 'package:bluetaxiapp/ui/views/base_widget.dart';
import 'package:bluetaxiapp/ui/widgets/responsive_ui_widgets.dart';
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
            body: Container(
              child: Column(
                children: [
                  //APP BAR CODE
                  Padding(
                    padding: smallPadding.copyWith(right: 0.0,top: width*0.025),
                    child: Row(
                      children: [
                        LeadingBackButton(
                          ontap: () {
                            Navigator.pop(context);
                          },
                          image:AssetImage('asset/icons/back_arrow.png'),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: width*0.5/3),
                          child: Text("Ride History",
                              style: boldHeading1.copyWith(color: onPrimaryColor)),
                        ),
                      ],
                    ),
                  ),

                  //USER INFO
                  Padding(
                    padding: smallPadding,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(70),
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.3),
                              )),
                          child: CustomImage(
                            ontap: () {},
                            fit: BoxFit.cover,
                            image: const AssetImage("asset/images/Group.png"),
                            height: height*1/10,
                            width: width*1/6,
                          ),
                        ),
                        Padding(
                          padding: smallPadding.copyWith(right: 0.0, bottom: 0.0, top: 0.0, left: width*0.025),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                driverDocument!.driverName??"test",
                                style:
                                boldHeading2.copyWith(color: onPrimaryColor),
                              ),
                              Text(
                                driverDocument!.carName?? 'Volkswegan Jetta',
                                style: heading2.copyWith(
                                    color: onPrimaryColor),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  //3 Cards in a ROW
                  Padding(
                    padding: smallPadding.copyWith(top:0.0, bottom: height*0.01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        profileContainer(AssetImage('asset/images/ic_rating.png',),driverDocument!.rating ?? "4.8"),
                        profileContainer(AssetImage('asset/images/ic_rating.png',),"126"),
                        profileContainer(AssetImage('asset/images/ic_calendar.png',),"2 years")
                      ],
                    ),
                  ),

                  //Card
                  Padding(
                    padding: smallPadding,
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
                            padding:smallPadding.copyWith(top: 0.0, bottom:0.0),
                            child: Divider(height: 2,color: secondaryColor2,),
                          ),
                          listTile(LabelCarType, "Van"),
                          Padding(
                            padding:smallPadding.copyWith(top: 0.0, bottom:0.0),
                            child: Divider(height: 2,color: secondaryColor2,),
                          ),
                          listTile(LabelPlateNumber, driverDocument!.carNumber?? "HS785K"),
                          Padding(
                            padding:smallPadding.copyWith(top: 0.0, bottom:0.0),
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
      ),
    );
  }

  Widget profileContainer(AssetImage icon, String text){
    return Container(
      width: width* 1.15/4,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
              color: secondaryColor2
          )
      ),
      child: Column(
        children: [
          Padding(
            padding: smallPadding.copyWith(bottom: height*0.01, top: height*0.01,),
            child: CircleAvatar(
              backgroundImage: icon,
              backgroundColor: Colors.transparent,
            ),
          ),
          Padding(
            padding: smallPadding.copyWith(bottom: height*0.01, top: 0.0),
            child: Text(text,),
          )
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
