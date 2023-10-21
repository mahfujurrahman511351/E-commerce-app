// ignore_for_file: prefer_const_constructors, unused_field

import 'package:ecommerce_app/views/dashboard/cart_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../constants/colors.dart';
import '../../controllers/product/cart_controller.dart';
import '../../controllers/product/data_controller.dart';
import '../../models/item_model.dart';
import '../../widget/drawer.dart';
import '../../widget/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _dataController = Get.put(DataController());
  final _cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Catelog App"),
      ),
      floatingActionButton: Obx(() {
        final controller = Get.find<CartController>();
        var cartItems = controller.uniqueCartItems;

        int totalCount = 0;

        for (var item in cartItems) {
          totalCount += controller.itemCount(item);
        }

        return Stack(
          alignment: Alignment.bottomRight,
          children: [
            FloatingActionButton(
              onPressed: () {
                Get.to(() => CartView());
              },
              backgroundColor: kBaseColor,
              child: Icon(
                CupertinoIcons.cart,
              ),
            ),
            cartItems.isEmpty
                ? Container()
                : Positioned(
                    top: 1.0, // Adjust the top position as needed
                    right: 1.0, // Adjust the right position as needed
                    child: Container(
                      height: 20,
                      width: 20,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.red, // Badge background color
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        totalCount.toString(), // Display the total count
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
          ],
        );
      }),
      drawer: const MyDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() {
            var datum = Get.find<DataController>().allData;
            bool loading = Get.find<DataController>().loadingData.value;

            return loading
                ? Center(
                    child: SizedBox(
                    height: 30,
                    width: 30,
                    child: LoadingIndicator(
                      indicatorType: Indicator.ballSpinFadeLoader,
                      colors: const [kBaseColor],
                      strokeWidth: 6,
                    ),
                  ))
                : datum.isEmpty
                    ? Center(
                        child: Text(
                          "No posts found yet!",
                          style: TextStyle(fontSize: 14),
                        ),
                      )
                    : ListView(
                        children: List.generate(datum.length, (index) {
                          Product item = datum[index];
                          return ProductCard(item: item);
                        }),
                      );
          }),
        ),
      ),
    );
  }
}
