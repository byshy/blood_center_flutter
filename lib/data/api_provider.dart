import 'dart:async';
import 'dart:convert';

import 'package:blood_center_flutter/data/local_provider.dart';
import 'package:blood_center_flutter/di.dart';
import 'package:blood_center_flutter/models/blood_centers_list.dart';
import 'package:blood_center_flutter/models/history_list.dart';
import 'package:blood_center_flutter/models/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiProvider {
  final Dio client;

  String baseUrl = 'http://bloodcenter.herokuapp.com/';

  ApiProvider({@required this.client});

  Future<User> login({Map<String, String> data}) async {
    var response;

    try {
      response = await client.post(
        '${baseUrl}auth/login/',
        data: data,
      );
    } on DioError catch (e) {
      print('error code: ${e.response.statusCode}');
      print('error is: ${e.response.data}');
    }
    final jsonData = json.decode(response.toString());
    User user = User.fromJson(jsonData);
    return user;
  }

  Future<HistoryList> getHistory() async {
    var response;

    String id = sl<LocalProvider>().getUser().info.id;

    try {
      response = await client.get(
        '${baseUrl}history/$id',
      );
    } on DioError catch (e) {
      print('error code: ${e.response.statusCode}');
      print('error is: ${e.response.data}');
    }
    HistoryList historyList = HistoryList.fromJson(response.data);
    return historyList;
  }

  Future<BloodCentersList> getCenters() async {
    var response;

    try {
      response = await client.get(
        '${baseUrl}blood_centers/',
      );
    } on DioError catch (e) {
      print('error code: ${e.response.statusCode}');
      print('error is: ${e.response.data}');
    }
    BloodCentersList centersList = BloodCentersList.fromJson(response.data);
    return centersList;
  }

}
