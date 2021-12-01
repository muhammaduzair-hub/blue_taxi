import 'package:bluetaxiapp/ui/shared/app_colors.dart';
import 'package:bluetaxiapp/ui/shared/text_styles.dart';
import 'package:bluetaxiapp/ui/shared/ui_helpers.dart';
import 'package:bluetaxiapp/ui/views/base_widget.dart';
import 'package:bluetaxiapp/ui/views/driver_detail_view.dart';
import 'package:bluetaxiapp/ui/views/trip_history_view.dart';
import 'package:bluetaxiapp/ui/widgets/leading_back_button.dart';
import 'package:bluetaxiapp/ui/widgets/primary_button.dart';
import 'package:bluetaxiapp/viewmodels/views/trip_summary_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class RideSummary extends StatelessWidget {
  final QuerySnapshot snapshot;
  final int index;

   RideSummary({Key? key, required this.snapshot, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String driverId = snapshot.docs[index]['riderId'];
    double size = MediaQuery
        .of(context)
        .size
        .height;
    size = size / 4;


    return BaseWidget<TripViewModel>(
        model: TripViewModel(
          authRepository: Provider.of(context), driverId: driverId,
          fromLatLng: LatLng(
            snapshot.docs[index]['Addresses']['from']['lat'],
            snapshot.docs[index]['Addresses']['from']['lng'],),
          toLatLng: LatLng(
            snapshot.docs[index]['Addresses']['to']['lat'],
            snapshot.docs[index]['Addresses']['to']['lng'],),
          fromTitle: snapshot.docs[index]['Addresses']['from']['place_name'],
          toTitle: snapshot.docs[index]['Addresses']['to']['place_name']
        ),
        builder: (context, model, child) => SafeArea(
        child: model.busy
        ? Center(
        child: CircularProgressIndicator(),
    )
        : Scaffold(
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
                    builder: (context) => new RideHistoryView()));
          },
          icon: AssetImage('asset/icons/back_btn.png'),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Stack(alignment: Alignment.topCenter, children: [
              Container(
                height: 250.0,
                child: GoogleMap(
                  scrollGesturesEnabled: false,
                  zoomControlsEnabled: false,
                  zoomGesturesEnabled : false,
                  markers: Set.of(model.markers),
                  initialCameraPosition: CameraPosition(
                      target: LatLng(
                        snapshot.docs[index]['Addresses']['from']['lat'],
                        snapshot.docs[index]['Addresses']['from']['lng'],
                      ),
                      zoom: 11),
                  mapType: MapType.terrain,
                  onTap: (latlng) {
                    print("${latlng.latitude}     ${latlng.longitude}");
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(21.0, size, 21.0, 20.0),
                child: Card(
                  elevation: 9,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(21.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      height: 80,
                                      child: Text(
                                        "",
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
                                    image: AssetImage(
                                        'asset/icons/routeIc.png')),
                                UIHelper.horizontalSpaceMedium,
                                Column(
                                  children: <Widget>[
                                    Container(
                                      height: 80,
                                      width: 200,
                                      child: Text(
                                        snapshot
                                            .docs[index]['Addresses']['from']
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
            ]),
            Padding(
              padding: UIHelper.pagePaddingMedium.copyWith(
                  right: 16.0, left: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    " Driver",
                    style: boldHeading2.copyWith(color: onPrimaryColor),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (
                          context) => DriverDetailView(driverDocument: model.driverDocument,),));

                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(21.0),
                        child: Row(
                          children: [
                            Container(
                              width: 72.0,
                              height: 72.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(3.0),
                                child: Center(
                                  child: Container(
                                    child:
                                    Image(image: AssetImage(
                                        'asset/images/Group.png')),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10, right: 70),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                  model.driverDocument!.driverName??"test",
                                    style:
                                    boldHeading2.copyWith(color: onPrimaryColor),
                                  ),
                                  Text(
                                    'Volkswegan Jetta',
                                    style: heading2.copyWith(
                                        color: onPrimaryColor),
                                  ),

                                  Row(
                                    children: [
                                      Icon(Icons.star,
                                        color: Colors.yellow, size: 15.0,),
                                      Text(
                                        model.driverDocument!.rating??"5.0",
                                        // model.driverDocument!.rating ?? '4.8',
                                        style: heading2.copyWith(
                                            color: onPrimaryColor),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios_outlined,
                              color: onPrimaryColor2, size: 15.0,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(21.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    " Payment",
                    style: boldHeading2.copyWith(color: onPrimaryColor),
                  ),
                  Card(
                    color: onPrimaryColor3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 21.0),
                      child: Row(
                        children: [
                          Container(
                            width: 72.0,
                            height: 72.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: onPrimaryColor3,
                            ),
                            child: Image(
                                image: AssetImage('asset/icons/shape.png')),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 100),
                            child: Text(
                              '**** 8295',
                              style:
                              boldHeading2.copyWith(color: onPrimaryColor),
                            ),
                          ),
                          Text(
                            '\$7',
                            style:
                            boldHeading2.copyWith(color: onPrimaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(21.0),
              child: Container(
                width: double.infinity,
                height: 50,
                child: PrimaryButton(
                    text: Text("Raise Issue"),
                    ontap: () {
                      //Bottom Sheet
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            padding: UIHelper.pagePaddingMedium.copyWith(top:21.0),
                            child: DraggableScrollableSheet(
                              initialChildSize: 1.0,
                              builder: (context, scrollController) =>
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Center(
                                          child: Image(
                                            image: AssetImage('asset/icons/ic_gesture.png'),
                                          )),
                                      UIHelper.verticalSpaceSmall,
                                      Text("Choose an option" ,style: buttonTextStyle.copyWith(fontWeight: FontWeight.w700),),
                                      UIHelper.verticalSpaceLarge,
                                      ListView.separated(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        separatorBuilder: (context, index){
                                          return Column(
                                            children: [
                                              SizedBox(height: 10.0,),
                                              Image(image:AssetImage('asset/icons/line.png')),
                                              SizedBox(height: 10.0,),
                                            ],
                                          );
                                        },
                                        itemCount: 7,
                                        itemBuilder: (
                                            BuildContext context,
                                            int index) {
                                          return _issueOptions(index);
                                        },
                                      ),
                                    ],
                                  ),
                            ),
                          );
                        },
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    )));
  }

  Widget _issueOptions(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("I was involved in an accident", style: heading2.copyWith(color: onPrimaryColor),),
        Icon(Icons.arrow_forward_ios_outlined, color: onPrimaryColor2,),
      ],
    );
  }
}