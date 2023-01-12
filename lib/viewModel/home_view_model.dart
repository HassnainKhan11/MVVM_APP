import 'package:flutter/foundation.dart';
import 'package:mvvm_project/data/response/api_response.dart';
import 'package:mvvm_project/model/user_list_moder.dart';

import '../repositories/home_repo.dart';

class HomeViewModel with ChangeNotifier {
  final _homeRepository = HomeRepository();

  ApiResponse<UserListModel> usersList = ApiResponse.loading();

  setUsersList(ApiResponse<UserListModel> response) {
    usersList = response;
    notifyListeners();
  }

  Future<void> fetchUsersList() async {
    setUsersList(ApiResponse.loading());
    _homeRepository.getUsersData().then((value) {
      setUsersList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setUsersList(ApiResponse.error(error.toString()));
    });
  }
}
