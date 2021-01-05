import 'package:flutter/material.dart';
import 'package:flutter_mask/model/store.dart';
import 'package:flutter_mask/ui/page/main_page.dart';
import 'package:flutter_mask/viewmodel/store_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider.value(
    value: StoreModel(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainPage(),
    );
  }
}
