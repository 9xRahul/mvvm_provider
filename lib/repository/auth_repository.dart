import 'package:provider_mvvm/data/network/base_api_service.dart';
import 'package:provider_mvvm/data/network/network_api_service.dart';
import 'package:provider_mvvm/resources/app_urls.dart';

class AuthRepository {
  final BaseApiServices _apiServices = NetworkApiServices();
  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.postResponse(
        AppUrls.loginEndPoint,
        data,
      );

      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> registerApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.postResponse(
        AppUrls.registerEndPOint,
        data,
      );

      return response;
    } catch (e) {
      throw e;
    }
  }
}
