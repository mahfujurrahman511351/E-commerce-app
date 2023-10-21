// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ecommerce_app/controllers/product/cart_controller.dart';
import 'package:ecommerce_app/models/item_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';

class CatalogView extends StatelessWidget {
  const CatalogView({super.key, required this.item});
  final Product item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Product Details"),
      ),
      bottomNavigationBar: _bottomBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              _image(),
              _divider(),
              _title(),
              _description(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomBar() {
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
                "\$${item.price}",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: kBaseColor,
                ),
              ),
              MaterialButton(
                onPressed: () {
                  Get.find<CartController>().addToCart(item);
                },
                color: kBaseColor,
                child: Icon(
                  CupertinoIcons.cart_fill_badge_plus,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _description() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        "${item.desc ?? ""} .Node.js is an open-source JavaScript runtime environment that allows developers to run JavaScript code outside of a web browser. It uses the V8 JavaScript engine, which is also used in Google Chrome, to execute JavaScript code on the server-side.",
        style: TextStyle(
          fontSize: 14,
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _title() {
    return Text(
      item.name ?? "",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: kBaseColor,
      ),
    );
  }

  Widget _divider() => Divider(color: Colors.grey);

  Widget _image() {
    return Hero(
      tag: Key(item.id.toString()),
      child: Image(
        image: NetworkImage(item.image ?? ""),
        height: 250,
        width: 150,
      ),
    );
  }
}
