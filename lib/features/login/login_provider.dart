import 'package:blood_center_flutter/data/api_provider.dart';
import 'package:blood_center_flutter/data/local_provider.dart';
import 'package:blood_center_flutter/features/home/home_ui.dart';
import 'package:blood_center_flutter/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../di.dart';

class LoginProvider with ChangeNotifier {
  bool logInLoading = false;
  User _user;
  User get user => _user;
  void login(BuildContext context, {Map<String, String> data}) {
    _user = null;
    logInLoading = true;
    print('start login');
    notifyListeners();
    sl<ApiProvider>().login(data: data).then((value) {
      logInLoading = false;
      _user = value;
      sl<LocalProvider>().setUser(_user);
      sl<LocalProvider>().setIsFirstLaunch(false);
      refreshToken();
      notifyListeners();
      print('finish login');
      if (_user.info != null) {
        print('user: ${_user.info.toString()}');
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => HomeUI()),
              (route) => false,
        );
//        WidgetsBinding.instance.addPostFrameCallback(
//              (timeStamp) => Navigator.pushAndRemoveUntil(
//            context,
//            MaterialPageRoute(builder: (_) => HomeUI()),
//                (route) => false,
//          ),
//        );
      }
    });
  }
}
