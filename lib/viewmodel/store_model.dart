import 'package:flutter/foundation.dart';
import 'package:flutter_mask/model/store.dart';
import 'package:flutter_mask/repository/location_repository.dart';
import 'package:flutter_mask/repository/store_repository.dart';
import 'package:geolocator/geolocator.dart';

class StoreModel with ChangeNotifier {
  final _storeRepository = StoreRepository();
  final _locationRepository = LocationRepository();
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

    Position position = await _locationRepository.getCurrentLocation();

    stores = await _storeRepository.getStoreListFilter(
        position.latitude, position.longitude);
    isLoading = false;
    notifyListeners();
  }
}
