import 'package:flutter/widgets.dart';
import 'package:provider_mvvm/repository/auth_repository.dart';
import 'package:provider_mvvm/utils/routes/routes_name.dart';
import 'package:provider_mvvm/utils/utils.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  setLoading(bool value) {
    _isLoading = value;

    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);
    _myRepo
        .loginApi(data)
        .then((value) {
          Utils.toastMessage("Login success");
          setLoading(false);
          Navigator.pushNamed(context, RoutesName.home);
        })
        .onError((error, stackTrace) {
          Utils.toastMessage("${error.toString()}");
          setLoading(false);
        });
  }
}
