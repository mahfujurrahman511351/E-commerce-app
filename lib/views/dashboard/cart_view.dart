// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../controllers/product/cart_controller.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart View"),
        centerTitle: true,
      ),
      body: _selectedProduct(),
      bottomNavigationBar: _bottomBar(),
    );
  }

  Widget _selectedProduct() {
    return Obx(() {
      final controller = Get.find<CartController>();
      var cartItems = controller.uniqueCartItems;
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: cartItems.isEmpty
              ? Center(
                  child: Text(
                    "Nothing to show",
                    style: TextStyle(fontSize: 20),
                  ),
                )
              : ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final product = cartItems[index];

                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.done),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(product.name ?? ""),
                                  SizedBox(height: 5),
                                  Text('\$${product.price}'),
                                ],
                              ),
                            ),
                            Card(
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      controller.removeFromCart(product);
                                    },
                                    icon: Icon(Icons.remove),
                                  ),
                                  Obx(() {
                                    int count = controller.itemCount(product);
                                    return Text(
                                      '$count',
                                      style: TextStyle(fontSize: 15),
                                    );
                                  }),
                                  IconButton(
                                    onPressed: () {
                                      controller.addToCart(product);
                                    },
                                    icon: Icon(Icons.add),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      );
    });
  }

  Widget _bottomBar() {
    return Obx(() {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            color: Colors.white,
            child: ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              buttonPadding: EdgeInsets.zero,
              children: [
                Text(
                  'Total: \$${cartController.totalAmount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: kBaseColor,
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Buying not supported yet."),
                    ));
                  },
                  color: kBaseColor,
                  child: Text(
                    "Buy",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
