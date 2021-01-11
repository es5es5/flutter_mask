import 'dart:convert';
import 'package:flutter_mask/model/store.dart';
import 'package:http/http.dart' as http;
import 'package:latlong/latlong.dart';

class StoreRepository {
  final _distance = Distance();

  Future<List<Store>> getStoreListFilter(double lat, double lng) async {
    final stores = List<Store>();

    var url =
        'https://gist.githubusercontent.com/junsuk5/bb7485d5f70974deee920b8f0cd1e2f0/raw/063f64d9b343120c2cb01a6555cf9b38761b1d94/sample.json';
    var response = await http.get(url);

    final jsonResult = jsonDecode(response.body);
    final jsonStores = jsonResult['stores'];

    jsonStores.forEach((item) {
      final store = Store.fromJson(item);
      final km = _distance.as(LengthUnit.Kilometer, LatLng(store.lat, store.lng), LatLng(lat, lng));

      if (store.remainStat == 'plenty' ||
          store.remainStat == 'some') {
        store.km = km;
        stores.add(store);
      }
    });
    return stores..sort((a, b) => a.km.compareTo(b.km));
  }

  Future<List<Store>> getStoreList() async {
    final stores = List<Store>();
    var url =
        'https://gist.githubusercontent.com/junsuk5/bb7485d5f70974deee920b8f0cd1e2f0/raw/063f64d9b343120c2cb01a6555cf9b38761b1d94/sample.json';
    var response = await http.get(url);

    final jsonResult = jsonDecode(response.body);
    final jsonStores = jsonResult['stores'];

    jsonStores.forEach((item) {
      final store = Store.fromJson(item);

      stores.add(store);
    });

    return stores;
  }
}