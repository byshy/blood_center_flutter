import 'package:blood_center_flutter/data/api_provider.dart';
import 'package:blood_center_flutter/data/local_provider.dart';
import 'package:blood_center_flutter/di.dart';
import 'package:blood_center_flutter/features/login/login_provider.dart';
import 'package:blood_center_flutter/features/login/login_ui.dart';
import 'package:blood_center_flutter/models/blood_centers_list.dart';
import 'package:blood_center_flutter/models/history_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeProvider with ChangeNotifier {
  bool historyLoading = false;
  HistoryList _historyList = HistoryList(historyList: List());

  HistoryList get historyList => _historyList;

  void getHistory() {
    _historyList = null;
    historyLoading = true;
    print('start loading history');
    notifyListeners();
    sl<ApiProvider>().getHistory().then((value) {
      _historyList = value;
      historyLoading = false;
      notifyListeners();
      print('finished loading history');
    });
  }

  bool centersLoading = false;
  BloodCentersList _centersList = BloodCentersList(centersList: List());

  BloodCentersList get centersList => _centersList;

  void getCenters(){
    _centersList = null;
    centersLoading = true;
    print('start loading centers');
    notifyListeners();
    sl<ApiProvider>().getCenters().then((value) {
      _centersList = value;
      centersLoading = false;
      notifyListeners();
      print('finished loading centers');
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
