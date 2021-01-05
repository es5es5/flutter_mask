import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mask/model/store.dart';
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
            return ListTile(
              title: Text(item.name),
              subtitle: Text(item.addr),
              trailing: _buildRemainStatWidget(item),
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

  Widget _buildRemainStatWidget(Store store) {
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
        Text(
          description,
          style: TextStyle(color: color),
        ),
      ],
    );
  }
}
