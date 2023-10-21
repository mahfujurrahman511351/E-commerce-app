import 'package:ecommerce_app/models/item_model.dart';
import 'package:get/get.dart';

import '../../services/data_service.dart';

class DataController extends GetxController {
  final _dataService = DataService();

  var allData = <Product>[].obs;

  var loadingData = false.obs;

  getData() async {
    loadingData.value = true;
    var response = await _dataService.getData();

    var dataList = response.data != null ? response.data as List<dynamic> : [];

    allData.clear();

    for (var item in dataList) {
      allData.add(item);
    }
    loadingData.value = false;
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
