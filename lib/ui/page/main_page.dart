import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mask/ui/widget/remain_stat_list_tile.dart';
import 'package:flutter_mask/viewmodel/store_model.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final storeModel = Provider.of<StoreModel>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('${storeModel.stores.length}곳'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.filter_list_outlined),
                onPressed: () {
                  storeModel.getStoreListFilter();
                }),
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  storeModel.getStoreList();
                }),
          ],
        ),
        body: storeModel.isLoading
            ? loadingWidget()
            : ListView(
          children: storeModel.stores.map((item) {
            return RemainStatListTile(item);
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

}
