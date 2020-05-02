import 'package:blood_center_flutter/data/api_provider.dart';
import 'package:blood_center_flutter/data/local_provider.dart';
import 'package:blood_center_flutter/di.dart';
import 'package:blood_center_flutter/features/login/login_provider.dart';
import 'package:blood_center_flutter/features/login/login_ui.dart';
import 'package:blood_center_flutter/models/history.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeProvider with ChangeNotifier {
  bool historyLoading = false;
  HistoryList _list = HistoryList(historyList: List());

  HistoryList get list => _list;

  void getHistory() {
    _list = null;
    historyLoading = true;
    print('start loading history');
    notifyListeners();
    sl<ApiProvider>().getHistory().then((value) {
      _list = value;
      historyLoading = false;
      notifyListeners();
      print('finished loading history');
    });
  }

  void logout(BuildContext context) {
    sl<LocalProvider>().removeUser();
    sl<LocalProvider>().setIsFirstLaunch(true);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                  child: LoginUI(),
                  create: (_) => LoginProvider(),
                )),
        (route) => false);
  }
}
