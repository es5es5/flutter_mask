import 'dart:convert';
import 'package:flutter_mask/model/store.dart';
import 'package:http/http.dart' as http;

class StoreRepository {
  Future<List<Store>> getStoreListFilter() async {
    final stores = List<Store>();

    var url =
        'https://gist.githubusercontent.com/junsuk5/bb7485d5f70974deee920b8f0cd1e2f0/raw/063f64d9b343120c2cb01a6555cf9b38761b1d94/sample.json';
    var response = await http.get(url);

    final jsonResult = jsonDecode(response.body);
    final jsonStores = jsonResult['stores'];

    jsonStores.forEach((item) {
      if (Store.fromJson(item).remainStat == 'plenty' ||
          Store.fromJson(item).remainStat == 'some') {
        stores.add(Store.fromJson(item));
      }
    });
    return stores;
  }

  Future<List<Store>> getStoreList() async {
    final stores = List<Store>();
    var url =
        'https://gist.githubusercontent.com/junsuk5/bb7485d5f70974deee920b8f0cd1e2f0/raw/063f64d9b343120c2cb01a6555cf9b38761b1d94/sample.json';
    var response = await http.get(url);

    final jsonResult = jsonDecode(response.body);
    final jsonStores = jsonResult['stores'];

    jsonStores.forEach((item) {
      stores.add(Store.fromJson(item));
    });

    return stores;
  }
}