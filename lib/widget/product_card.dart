// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import '../controllers/product/cart_controller.dart';
import '../models/item_model.dart';
import '../views/dashboard/product_details_view.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key, required this.item});

  final Product item;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Get.to(() => CatalogView(item: widget.item));
        },
        child: Card(
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                _image(),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _title(),
                      SizedBox(height: 8),
                      _description(),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _price(),
                          _button(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _button() {
    return MaterialButton(
      minWidth: 30,
      height: 25,
      onPressed: () {
        cartController.addToCart(widget.item);
      },
      child: Icon(
        CupertinoIcons.cart_fill_badge_plus,
        color: Colors.white,
      ),
      color: kBaseColor,
    );
  }

  Widget _price() {
    return Text(
      "\$${widget.item.price}",
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: kBaseColor,
      ),
    );
  }

  Widget _description() {
    return Text(
      widget.item.desc ?? "",
      style: TextStyle(
        fontSize: 14,
      ),
    );
  }

  Widget _title() {
    return Text(
      widget.item.name ?? "",
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _image() {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Hero(
        tag: Key(widget.item.id.toString()),
        child: Image.network(
          widget.item.image ?? "",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
