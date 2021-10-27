import 'package:bluetaxiapp/practice/provider/homeScreen.dart';
import 'package:bluetaxiapp/practice/provider/item_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ItemAddNotifier>(
        create: (BuildContext context) {
          return ItemAddNotifier();
        },
        child:MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
        ));
  }
}