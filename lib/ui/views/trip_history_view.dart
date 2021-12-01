import 'package:bluetaxiapp/ui/shared/app_colors.dart';
import 'package:bluetaxiapp/ui/shared/globle_objects.dart';
import 'package:bluetaxiapp/ui/shared/text_styles.dart';
import 'package:bluetaxiapp/ui/shared/ui_helpers.dart';
import 'package:bluetaxiapp/ui/views/trip_summary.dart';
import 'package:bluetaxiapp/ui/views/user_menu_view.dart';
import 'package:bluetaxiapp/ui/widgets/leading_back_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RideHistoryView extends StatelessWidget {

  var historyTrip = FirebaseFirestore.instance
      .collection('request')
      .where('userId', isEqualTo: signedINUser.id)

      .orderBy('createDate', descending: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
        title: Text("Ride History",
            style: boldHeading1.copyWith(color: onPrimaryColor)),
        leading: LeadingBackButton(
          radius: 30.0,
          ontap: () {
            Navigator.pop(context);
          },
          icon: AssetImage('asset/icons/nav_btn.png'),
        ),
      ),
      body: StreamBuilder(
        stream: historyTrip,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                    height: 10,
                  ),
              itemCount: snapshot.data != null ? snapshot.data!.docs.length: 0,
              itemBuilder: (context, int index) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                return CustomCard(
                  snapshot: snapshot.data!,
                  index: index,
                );
              });
        },
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final QuerySnapshot snapshot;
  final int index;

  CustomCard({Key? key, required this.snapshot, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
          ),
          padding: EdgeInsets.symmetric(horizontal: 21.0),
          height: 220,
          child: snapshot.docs[index]['rideStatus'] !="Cancelled"?GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) =>  RideSummary(snapshot: snapshot, index: index,)));
            },
            child:MyCard(snapshot: snapshot, index: index)
          ):
          MyCard(snapshot: snapshot, index: index, elevatin: 0)
        ),
      ],
    );
  }


  Widget MyCard({required QuerySnapshot snapshot, required int index, int elevatin = 9}){

    DateTime date = (snapshot.docs[index]['createDate']).toDate();
    return  Card(
      elevation: elevatin.toDouble(),
      child: Column(
        children: <Widget>[
          Padding(
            padding: UIHelper.pagePaddingSmall.copyWith(bottom: 4),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${date}",
                      style:
                      boldHeading3.copyWith(color: onPrimaryColor),
                    ),
                    if (snapshot.docs[index]['rideStatus'] ==
                        "Cancelled")
                      Text(
                        "CANCELLED",
                        style: boldHeading3.copyWith(color: Colors.red),
                      ),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          height: 80,
                          child: Text(
                            "${date.hour}:${date.minute}",
                            style: heading2.copyWith(
                                fontWeight: FontWeight.w400,
                                color: onPrimaryColor2),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        UIHelper.verticalSpaceSmall,
                        Container(
                          child: Text(
                            "",
                            style: heading2.copyWith(
                                fontWeight: FontWeight.w400,
                                color: onPrimaryColor2),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                    UIHelper.horizontalSpaceMedium,
                    Image(
                        height: 105.0,
                        image: AssetImage('asset/icons/routeIc.png')),
                    UIHelper.horizontalSpaceMedium,
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 80,
                            width: 200,
                            child: Text(
                              snapshot.docs[index]['Addresses']['from']
                              ['place_name'],
                              style: heading2.copyWith(
                                  fontWeight: FontWeight.w400),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          UIHelper.verticalSpaceSmall,
                          Container(
                            width: 200,
                            child: Text(
                              snapshot.docs[index]['Addresses']['to']
                              ['place_name'],
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
