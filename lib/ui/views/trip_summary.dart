import 'package:bluetaxiapp/ui/shared/app_colors.dart';
import 'package:bluetaxiapp/ui/shared/globle_objects.dart';
import 'package:bluetaxiapp/ui/shared/text_styles.dart';
import 'package:bluetaxiapp/ui/shared/ui_helpers.dart';
import 'package:bluetaxiapp/ui/views/base_widget.dart';
import 'package:bluetaxiapp/ui/views/driver_detail_view.dart';
import 'package:bluetaxiapp/ui/views/trip_history_view.dart';
import 'package:bluetaxiapp/ui/widgets/responsive_ui_widgets.dart';
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
    double size = MediaQuery.of(context).size.height;
    size = size / 4;
    DateTime date = (snapshot.docs[index]['createDate']).toDate();

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
        title: Text("Ride Details",
            style: boldHeading1.copyWith(color: onPrimaryColor)),
        leading: Padding(
          padding: smallPadding.copyWith(top: width * 0.025, bottom: width * 0.025, right: 0.0),
          child: LeadingBackButton(
            ontap: () {
              Navigator.pop(context);
            },
            image:AssetImage('asset/icons/back_arrow.png'),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Stack(alignment: Alignment.topCenter, children: [
              Container(
                height: height*0.3,
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
                padding: smallPadding.copyWith(top: height*0.25),
                child: Hero(
                  tag: "rideCard",
                  child: Card(
                    child: Padding(
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
                                  "${date.hour}:${date.minute}",
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
                  ),
                ),
              ),
            ]),

            //Driver Info Card
            Padding(
              padding: smallPadding,
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
                      elevation: 9,
                      child: Padding(
                        padding: smallPadding,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                    height: height * 0.1,
                                    width: width * 1 / 6,
                                  ),
                                ),
                                Padding(
                                  padding: smallPadding.copyWith(right: 0.0, bottom: 0.0, top: 0.0, left: width*0.025),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
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

            //Payment Info Card
            Padding(
              padding: smallPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    " Payment",
                    style: boldHeading2.copyWith(color: onPrimaryColor),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: onPrimaryColor3,
                        border: Border.all(
                            color: secondaryColor2
                        )
                    ),
                    child: Padding(
                      padding: smallPadding,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: onPrimaryColor3,
                                ),
                                child: Image(
                                    image: snapshot.docs[index]['payment']['card_no']=="Cash"?AssetImage("asset/icons/ic_cash.png"): AssetImage('asset/icons/shape.png')),
                              ),
                              Text(
                                snapshot
                                    .docs[index]['payment']['card_no'],
                                style:
                                boldHeading2.copyWith(color: onPrimaryColor),
                              ),
                            ],
                          ),
                          Text(
                            '\$${snapshot.docs[index]['expectedBill']}',
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

            //Raise Issue Button
            Padding(
              padding: smallPadding,
              child: SizedBox(
                height: height * 0.06,
                width: double.infinity,
                child: PrimaryButton(
                    text: Text("Raise Issue"),
                    ontap: () {
                      //Bottom Sheet
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            child: Padding(
                              padding: smallPadding,
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
                                        Text("Choose an option" ,style: buttonTextStyle.copyWith(fontWeight: FontWeight.w700),),
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