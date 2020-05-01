import 'package:blood_center_flutter/models/user_info.dart';

class User {
    String token;
    UserInfo info;

    User({this.token, this.info});

    factory User.fromJson(Map<String, dynamic> json) {
        return User(
            token: json['token'], 
            info: json['user'] != null ? UserInfo.fromJson(json['user']) : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['token'] = this.token;
        if (this.info != null) {
            data['user'] = this.info.toJson();
        }
        return data;
    }

    @override
    String toString() {
      return 'token: $token, info: $info';
    }

}