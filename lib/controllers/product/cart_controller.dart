import 'package:ecommerce_app/constants/helper_functions.dart';
import 'package:get/get.dart';

import '../../models/item_model.dart';

class CartController extends GetxController {
  var cartItems = <Product>[].obs;
  var uniqueCartItems = <Product>[].obs;
  var totalAmount = 0.0.obs;

  var addingToCart = false.obs;

  int itemCount(Product item) {
    return cartItems.where((product) => product == item).length;
  }

  addToCart(Product item) {
    if (!addingToCart.value) {
      addingToCart.value = true;

      cartItems.add(item);
      addToUniueCart(item);
      calculateTotal();
      showSnackBar(message: "Added to Cart");
      addingToCart.value = false;
    }
  }

  addToUniueCart(Product item) {
    bool exists = uniqueCartItems.contains(item);
    if (!exists) {
      uniqueCartItems.add(item);
    }
  }

  void removeFromCart(Product item) {
    cartItems.remove(item);
    calculateTotal();

    bool exists = cartItems.contains(item);
    if (!exists) {
      uniqueCartItems.remove(item);
    }
  }

  void calculateTotal() {
    totalAmount.value = cartItems.fold<double>(0, (total, item) => total + (item.price ?? 0));
  }
}
