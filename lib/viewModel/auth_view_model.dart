import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mvvm_project/model/user_mode.dart';
import 'package:mvvm_project/repositories/auth_repo.dart';
import 'package:mvvm_project/utilities/routes/routes_names.dart';
import 'package:mvvm_project/utilities/utils.dart';
import 'package:mvvm_project/viewModel/user_view_model.dart';
import 'package:provider/provider.dart';

class AuthViewModel with ChangeNotifier {
  final _myrepo = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;

  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

  setSignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);

    _myrepo.loginApi(data).then((value) {
      setLoading(false);
      final userPreferences =
          Provider.of<UserViewModel>(context, listen: false);
      userPreferences.saveUser(
        UserModel(token: value['token']),
      );

      Utils.flushBarErrorMessage(value.toString(), context);
      Navigator.pushNamed(context, RoutesName.home);
    }).onError((error, stackTrace) {
      Utils.flushBarErrorMessage(error.toString(), context);
    });
  }

  Future<void> registerApi(dynamic data, BuildContext context) async {
    setSignUpLoading(true);
    _myrepo.registerApi(data).then((value) {
      Utils.flushBarErrorMessage(value.toString(), context);
      Navigator.pushNamed(context, RoutesName.login);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setSignUpLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
    });
  }
}
