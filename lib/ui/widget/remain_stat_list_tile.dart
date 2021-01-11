import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mask/model/store.dart';
import 'package:url_launcher/url_launcher.dart';

class RemainStatListTile extends StatelessWidget {
  final Store store;

  RemainStatListTile(this.store);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(store.name),
        subtitle: Text(store.addr),
        trailing: _buildRemainStatWidget(store),
        onTap: () {
          _launchURL(store.lat, store.lng);
        });
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

  _launchURL(double lat, double lng) async {
    final url = 'https://google.com/maps/search/?api=1&query=$lat,$lng';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'nono $url';
    }
  }
}
