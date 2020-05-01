import 'dart:async';
import 'dart:convert';

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
    print('user: ${user.toString()}');
    return user;
  }

}
