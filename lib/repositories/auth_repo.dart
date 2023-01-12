import 'package:mvvm_project/data/network/baseApiServices.dart';
import 'package:mvvm_project/data/network/networkApiServices.dart';
import 'package:mvvm_project/resources/app_url.dart';

class AuthRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  // hit login api method
  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.loginUrl, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> registerApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.registerUrl, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
