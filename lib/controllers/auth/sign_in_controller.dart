import 'package:get/get.dart';

import '../../views/dashboard/home.dart';

class SigninController extends GetxController {
  var hidePassword = true.obs;
  var name = "".obs;

  var changedButton = false.obs;

  handleLogin() async {
    if (!changedButton.value) {
      changedButton.value = true;
      await Future.delayed(const Duration(seconds: 1));
      Get.to(() => const HomePage());
      changedButton.value = false;
    } else {
      changedButton.value = false;
    }
  }
}
