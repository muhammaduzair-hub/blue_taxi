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
            Navigator.pop(context);
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
                  right: 21.0, left: 21.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    " Driver",
                    style: boldHeading2.copyWith(color: onPrimaryColor),
                  ),
                  SizedBox(height: 5.0),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (
                          context) => DriverDetailView(driverDocument: model.driverDocument,),));

                    },
                    child: Card(
                      elevation: 9,
                      child: Padding(
                        padding: UIHelper.pagePaddingSmall.copyWith(top: 15,bottom:15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: Center(
                                    child: Image(image: AssetImage(
                                        'asset/images/Group.png')),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        model.driverDocument!.driverName??"test",
                                        style:
                                        boldHeading2.copyWith(color: onPrimaryColor),
                                      ),
                                      Text(
                                        model.driverDocument!.carName?? 'Volkswegan Jetta',
                                        style: heading2.copyWith(
                                            color: onPrimaryColor),
                                      ),

                                      Row(
                                        children: [
                                          Icon(Icons.star,
                                            color: Colors.yellow, size: 15.0,),
                                          SizedBox(width: 2.0,),
                                          Text(
                                            model.driverDocument!.rating??"0.0",
                                            // model.driverDocument!.rating ?? '4.8',
                                            style: heading2.copyWith(
                                                color: onPrimaryColor),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
              padding: UIHelper.pagePaddingMedium.copyWith(
                  right: 21.0, left: 21.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    " Payment",
                    style: boldHeading2.copyWith(color: onPrimaryColor),
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: onPrimaryColor3,
                        border: Border.all(
                            color: secondaryColor2
                        )
                    ),
                    child: Padding(
                      padding: UIHelper.pagePaddingSmall.copyWith(top: 10,bottom:10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: onPrimaryColor3,
                                  ),
                                  child: Image(
                                      image: snapshot.docs[index]['payment']['card_no']=="Cash"?AssetImage("asset/icons/ic_cash.png"): AssetImage('asset/icons/shape.png')),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:10.0),
                                child: Text(
                                  snapshot
                                      .docs[index]['payment']['card_no'],
                                  style:
                                  boldHeading2.copyWith(color: onPrimaryColor),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Text(
                              '\$${snapshot.docs[index]['expectedBill']}',
                              style:
                              boldHeading2.copyWith(color: onPrimaryColor),
                            ),
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
                                        itemCount: model.reasonList.length,
                                        itemBuilder: (
                                            BuildContext context,
                                            int index) {
                                          return _issueOptions(index, model);
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

  Widget _issueOptions(int index, TripViewModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(model.reasonList[index].vText, style: heading2.copyWith(color: onPrimaryColor),),
        Icon(Icons.arrow_forward_ios_outlined, color: onPrimaryColor2,),
      ],
    );
  }
}