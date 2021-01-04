import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mask/model/store.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final stores = List<Store>();
  var isLoading = true;

  Future fetch() async {
    setState(() {
      isLoading = true;
    });
    var url =
        'https://gist.githubusercontent.com/junsuk5/bb7485d5f70974deee920b8f0cd1e2f0/raw/063f64d9b343120c2cb01a6555cf9b38761b1d94/sample.json';
    var response = await http.get(url);

    final jsonResult = jsonDecode(response.body);
    final jsonStores = jsonResult['stores'];

    setState(() {
      stores.clear();
      jsonStores.forEach((item) {
        stores.add(Store.fromJson(item));
      });
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('마스크 재고 있는 곳 : ${stores.length}곳'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.refresh), onPressed: fetch)
          ],
        ),
        body: isLoading
            ? loadingWidget()
            : ListView(
                children: stores.map((item) {
                  return ListTile(
                    title: Text(item.name),
                    subtitle: Text(item.addr),
                    trailing: _buildRemainSatatWidget(item),
                  );
                }).toList(),
              ));
  }

  Widget loadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('정보를 가져오는 중 입니다..'),
          CircularProgressIndicator(),
        ],
      ),
    );
  }

  Widget _buildRemainSatatWidget(Store store) {
    var remainStat = '판매중지';
    var description = '판매중지';
    var color = Colors.black;

    switch (store.remainStat) {
      case 'plenty':
        remainStat = '충분';
        description = '100개 이상';
        color = Colors.green;
        break;
      case 'some':
        remainStat = '보통';
        description = '30개 이상';
        color = Colors.yellow;
        break;
      case 'few':
        remainStat = '부족';
        description = '2개 이상';
        color = Colors.red;
        break;
      case 'empty':
        remainStat = '소진임박';
        description = '1개 이하';
        color = Colors.grey;
        break;
      default:
        remainStat = '판매중지';
        description = '판매중지';
        color = Colors.black;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          remainStat,
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
        Text(description,
        style: TextStyle(color: color),),
      ],
    );
  }
}
