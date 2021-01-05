import 'package:flutter/foundation.dart';
import 'package:flutter_mask/model/store.dart';
import 'package:flutter_mask/repository/store_repository.dart';

class StoreModel with ChangeNotifier {
  final _storeRepository = StoreRepository();
  var isLoading = false;
  List<Store> stores = [];

  Future getStoreList() async {
    isLoading = true;
    notifyListeners();

    stores = await _storeRepository.getStoreList();
    isLoading = false;
    notifyListeners();
  }

  Future getStoreListFilter() async {
    isLoading = true;
    notifyListeners();

    stores = await _storeRepository.getStoreListFilter();
    isLoading = false;
    notifyListeners();
  }
}