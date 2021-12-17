
import 'package:bluetaxiapp/constants/strings.dart';
import 'package:bluetaxiapp/ui/shared/app_colors.dart';
import 'package:bluetaxiapp/ui/shared/text_styles.dart';
import 'package:bluetaxiapp/ui/shared/ui_helpers.dart';
import 'package:bluetaxiapp/ui/widgets/leading_back_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SupportView extends StatelessWidget {
   SupportView({Key? key}) : super(key: key);
  List<String> questionsList = ["Frequently asked questions","Your support tickets","Contact us"];


  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (p0, p1, p2){
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            foregroundColor: secondaryColor,
            elevation: 0.0,
            backgroundColor: secondaryColor,
            shadowColor: secondaryColor,
            centerTitle: true,
            leading: LeadindBackButton(
              ontap: (){Navigator.pop(context);},
              icon: AssetImage('asset/icons/nav btn.png'),
            ),
            title: Text(LabelSupport,style: boldHeading1.copyWith(color: onSecondaryColor)),
          ),
          body: Stack(
            children: [
              Container(
                //This is back grround blue container
                height: 30.h,
                color: secondaryColor,
              ),
             Padding(
               padding:EdgeInsets.symmetric(horizontal: 3.w),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   SizedBox(height: 23.h,),
                   Container(
                     padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 2.w),
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(15),
                       color: Colors.white,
                       boxShadow: [
                         BoxShadow(
                           color: Colors.grey.withOpacity(0.3),
                           spreadRadius: 3,
                           blurRadius: 5,
                           offset: Offset(0, 3), //
                         )
                       ]
                     ),
                     child: ListView.separated(
                       shrinkWrap: true,
                         itemBuilder: (context, index) => questionListTile(questionsList[index]),
                         separatorBuilder: (context, index) => Container(height: 1,margin: EdgeInsets.symmetric(horizontal: 3.w),color: Colors.grey.withOpacity(0.5),),
                         itemCount: 3
                     )
                   ),
                   SizedBox(height: 3.h,),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       profileContainer(AssetImage('asset/images/ic_rating.png',),"Option 1"),
                       profileContainer(AssetImage('asset/images/ic_rating.png',),"Option 2"),
                       profileContainer(AssetImage('asset/images/ic_calendar.png',),"Option 3")
                     ],
                   )
                 ],
               ),
             )
            ],
          ),
        ),
      );
    });
  }

  Widget questionListTile(String text){
    return ListTile(
      title: Text(text,style: TextStyle(color: Colors.black.withOpacity(0.5),),),
      trailing: Icon(Icons.arrow_forward_ios_sharp,color: Colors.black.withOpacity(0.3),),
    );
  }

   Widget profileContainer(AssetImage icon, String text){
     return Container(
       padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 1.h),
       width: 26.w,

       decoration: BoxDecoration(
           color: Colors.white,
           borderRadius: BorderRadius.circular(15),
           boxShadow: [
             BoxShadow(
               color: Colors.grey.withOpacity(0.3),
               spreadRadius: 3,
               blurRadius: 5,
               offset: Offset(0, 3), //
             )
           ]
       ),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           CircleAvatar(backgroundImage: icon,backgroundColor: Colors.transparent,radius: 2.h,),
           SizedBox(height: 3.h,),
           Container(
               height: 3.h,
               child: Text(text,style: boldHeading2,)),
         ],
       ),
     );
   }

}
