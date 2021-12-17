import 'package:bluetaxiapp/ui/shared/app_colors.dart';
import 'package:bluetaxiapp/ui/shared/globle_objects.dart';
import 'package:bluetaxiapp/ui/shared/text_styles.dart';
import 'package:bluetaxiapp/ui/views/trip_summary.dart';
import 'package:bluetaxiapp/ui/widgets/responsive_ui_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RideHistoryView extends StatelessWidget {

  var historyTrip = FirebaseFirestore.instance.collection('request').where('userId', isEqualTo: signedINUser.id).orderBy('createDate', descending: true).snapshots();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Column(
              children: [
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
                SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: StreamBuilder(
                    stream: historyTrip,
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      return ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
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
                ),
              ],
            ),
          ),
        ),
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
        IntrinsicHeight(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40.0),
            ),
            child: snapshot.docs[index]['rideStatus'] !="Cancelled"?
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) =>  RideSummary(snapshot: snapshot, index: index,)));
              },
              child:Padding(
                padding: smallPadding.copyWith(top: height*0.01, bottom: 0.0),
                child: MyCard(snapshot: snapshot, index: index, width: MediaQuery.of(context).size.width),
              )
            ):
            Padding(
              padding: smallPadding,
              child: MyCard(snapshot: snapshot, index: index, elevatin: 0, width: MediaQuery.of(context).size.width),
            )
          ),
        ),
      ],
    );
  }


  Widget MyCard({required QuerySnapshot snapshot, required int index, int elevatin = 9,required double width}){

    DateTime date = (snapshot.docs[index]['createDate']).toDate();
    int v = double.parse(snapshot.docs[index]['expectedBill']).toInt();
    DateTime endTime = date.add(Duration(minutes: v));
    
    return  Hero(
      tag: "rideCard",
      child: Card(
        elevation: elevatin.toDouble(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: width * 1 / 30, left: width * 1 / 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}",
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
            ),
            Divider(),
            Padding(
              padding:smallPadding.copyWith(top: height*0.02, bottom: height*0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "${date.hour}:${date.minute}",
                          style: heading2.copyWith(
                              fontWeight: FontWeight.w400,
                              color: onPrimaryColor2),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(height: width*1/10,),
                      Container(
                        child: Text(
                          "${endTime.hour}:${endTime.minute}",
                          style: heading2.copyWith(
                              fontWeight: FontWeight.w400,
                              color: onPrimaryColor2),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: Image(
                        image: AssetImage('asset/icons/ic_route.png')),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Text(
                            snapshot.docs[index]['Addresses']['from']
                            ['place_name'],
                            style: heading2.copyWith(
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(height: width*1/20,),
                        Container(
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
            ),
          ],
        ),
      ),
    );
  }
}