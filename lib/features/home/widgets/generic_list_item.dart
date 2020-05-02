import 'package:flutter/material.dart';

class GenericListItem extends StatelessWidget {
  final String id;
  final String value;

  const GenericListItem({Key key, this.id, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Text(id),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 2,
          child: Text(value),
        ),
      ],
    );
  }
}
