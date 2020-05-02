import 'package:blood_center_flutter/features/home/widgets/generic_list_item.dart';
import 'package:blood_center_flutter/models/user_info.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final UserInfo info;

  const UserCard({Key key, this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            GenericListItem(
              id: 'رقم الهوية',
              value: info.id,
            ),
            GenericListItem(
              id: 'الإيميل',
              value: info.email,
            ),
            GenericListItem(
              id: 'الإسم الأول',
              value: info.firstName,
            ),
            GenericListItem(
              id: 'الإسم الأخير',
              value: info.lastName,
            ),
            GenericListItem(
              id: 'رقم الجوال',
              value: info.mobile,
            ),
          ],
        ),
      ),
    );
  }
}
