import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http_city/http_city/model/http_city_model.dart';
import '../view/http_city.dart';
import 'package:http/http.dart' as http;

abstract class HttpCityViewModel extends State<HttpCity> {
  final baseUrl = "https://city-turkey.firebaseio.com/";
  bool isLoading = false;
  List<HttpCityModel> httpCity = [];

  @override
  void initState() {
    super.initState();
    callItems();
  }

  Future<void> callItems() async {
    changeLoading();
    await _getHttpCity();
    changeLoading();
    checkErrorList();
  }

  void checkErrorList() {
    if (httpCity.isEmpty) {
      showDialog(
          context: context,
          builder: (context) => Dialog(
                child: Text("Opps.. Something get Wrong"),
              ));
    }
  }

  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  Future<void> _getHttpCity() async {
    final response = await http.get("$baseUrl/city.json");
    switch (response.statusCode) {
      case HttpStatus.ok:
        final jsonBody = jsonDecode(response.body);
        if (jsonBody is List) {
          httpCity = jsonBody.map((e) => HttpCityModel.fromJson(e)).toList();
        }

        break;
      default:
    }
  }
}
