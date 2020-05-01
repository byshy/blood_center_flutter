class UserInfo {
    String email;
    String firstName;
    String lastName;
    int pk;
    String username;

    UserInfo({this.email, this.firstName, this.lastName, this.pk, this.username});

    factory UserInfo.fromJson(Map<String, dynamic> json) {
        return UserInfo(
            email: json['email'],
            firstName: json['first_name'],
            lastName: json['last_name'],
            pk: json['pk'], 
            username: json['username'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['email'] = this.email;
        data['first_name'] = this.firstName;
        data['last_name'] = this.lastName;
        data['pk'] = this.pk;
        data['username'] = this.username;
        return data;
    }

    @override
    String toString() {
        return '{email: $email, firstName: $firstName, lastName: $lastName, pk: $pk, username: $username}';
    }
}