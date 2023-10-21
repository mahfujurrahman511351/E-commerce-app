// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/api_response.dart';
import '../models/item_model.dart';

class DataService {
  Future<ApiResponse> getData() async {
    final apiResponse = ApiResponse();

    try {
      var response = await rootBundle.loadString("assets/data/catalog.json");

      var json = jsonDecode(response);

      var responseData = json['products'].map((item) => Product.fromJson(item)).toList();

      apiResponse.data = responseData;

      responseData as List<dynamic>;
    } catch (e) {
      print("Error loading JSON:$e");
      apiResponse.error = "Error loading JSON:$e";
    }
    return apiResponse;
  }
}
