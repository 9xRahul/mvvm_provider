import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider_mvvm/data/app_exceptions.dart';
import 'package:provider_mvvm/data/network/base_api_service.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future<dynamic> getResponse(String url) async {
    dynamic jsonresponse;
    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(Duration(seconds: 3));
      jsonresponse = returnResponse(response);

      return jsonresponse;
    } on SocketException {
      throw FetchDataException("No internet connection");
    }
  }

  @override
  Future<dynamic> postResponse(String url, dynamic data) async {
    dynamic jsonresponse;
    try {
      debugPrint(data.toString());
      http.Response response = await http
          .post(Uri.parse(url), body: data)
          .timeout(Duration(seconds: 10));

      print(response.statusCode);
      print(url);
      jsonresponse = returnResponse(response);

      return jsonresponse;
    } on SocketException {
      throw FetchDataException("No internet connection");
    }
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic resposeJson = jsonDecode(response.body);
        return resposeJson;
      case 400:
        throw BadRequestException();
      default:
        throw FetchDataException('Error while communicating with server');
    }
  }
}
