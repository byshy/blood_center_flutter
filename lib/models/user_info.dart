class UserInfo {
    String id;
    String email;
    String firstName;
    String lastName;
    String mobile;

    UserInfo({this.email, this.firstName, this.lastName, this.id, this.mobile});

    factory UserInfo.fromJson(Map<String, dynamic> json) {
        return UserInfo(
            id: json['id'],
            email: json['email'],
            firstName: json['first_name'],
            lastName: json['last_name'],
            mobile: json['mobile'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['email'] = this.email;
        data['first_name'] = this.firstName;
        data['last_name'] = this.lastName;
        data['mobile'] = this.mobile;
        return data;
    }

    @override
    String toString() {
        return '{id: $id, email: $email, firstName: $firstName, lastName: $lastName, mobile: $mobile}';
    }
}