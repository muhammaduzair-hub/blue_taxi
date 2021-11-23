import 'package:bluetaxiapp/ui/shared/app_colors.dart';
import 'package:bluetaxiapp/ui/shared/globle_objects.dart';
import 'package:bluetaxiapp/ui/shared/text_styles.dart';
import 'package:bluetaxiapp/ui/shared/ui_helpers.dart';
import 'package:bluetaxiapp/ui/views/base_widget.dart';
import 'package:bluetaxiapp/ui/views/trip_summary.dart';
import 'package:bluetaxiapp/ui/views/user_menu_view.dart';
import 'package:bluetaxiapp/ui/widgets/leading_back_button.dart';
import 'package:bluetaxiapp/viewmodels/views/trip_summary_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class RideHistoryView extends StatelessWidget {

  var historyTrip = FirebaseFirestore.instance
      .collection('request')
      .where('userId', isEqualTo: signedINUser.id)
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
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new UserMenuView()));
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
              itemCount: snapshot.data!.docs.length,
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
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new RideSummary(snapshot: snapshot, index: index,)));
            },
            child: Card(
              elevation: 9,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(21.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "21 Nov 2021, 18:39",
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
                                    "11:24",
                                    style: heading2.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: onPrimaryColor2),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                UIHelper.verticalSpaceSmall,
                                Container(
                                  child: Text(
                                    "11:38",
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
                            Column(
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
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
