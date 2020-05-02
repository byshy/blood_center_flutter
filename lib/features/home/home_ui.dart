import 'package:blood_center_flutter/data/local_provider.dart';
import 'package:blood_center_flutter/di.dart';
import 'package:blood_center_flutter/features/home/home_provider.dart';
import 'package:blood_center_flutter/features/home/widgets/generic_list_item.dart';
import 'package:blood_center_flutter/features/home/widgets/user_card.dart';
import 'package:blood_center_flutter/models/history.dart';
import 'package:blood_center_flutter/models/user_info.dart';
import 'package:blood_center_flutter/utils/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeUI extends StatefulWidget {
  @override
  _HomeUIState createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  UserInfo info;

  @override
  void initState() {
    super.initState();
    info = sl<LocalProvider>().getUser().info;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<HomeProvider>(context, listen: false).getHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[200],
        title: Text(
          'Blood Center',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {},
          )
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        primary: true,
        children: <Widget>[
          UserCard(
            info: info,
          ),
          SizedBox(
            height: 10,
          ),
          Consumer<HomeProvider>(
            builder: (context, instance, child) {
              if (instance.historyLoading) {
                return Center(child: LoadingIndicator());
              } else if (instance.list.historyList.isNotEmpty &&
                  !instance.historyLoading) {
                return historyList(instance.list.historyList);
              }
              return child;
            },
            child: Text('Nothing to show yet', textAlign: TextAlign.center,),
          )
        ],
      ),
    );
  }

  Widget historyList(List<History> list) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: list.length,
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            GenericListItem(
              id: 'Date:',
              value: list[index].date.toString(),
            ),
            GenericListItem(
              id: 'Center:',
              value: list[index].bloodCenterId,
            ),
          ],
        );
      },
    );
  }
}
