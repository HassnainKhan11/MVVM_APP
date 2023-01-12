import '../data/network/baseApiServices.dart';
import '../data/network/networkApiServices.dart';
import '../model/user_list_moder.dart';
import '../resources/app_url.dart';

class HomeRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<UserListModel> getUsersData() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.usersListUrl);
      return response = UserListModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
