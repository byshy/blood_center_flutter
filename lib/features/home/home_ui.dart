import 'package:blood_center_flutter/data/local_provider.dart';
import 'package:blood_center_flutter/di.dart';
import 'package:blood_center_flutter/features/home/home_provider.dart';
import 'package:blood_center_flutter/features/home/widgets/generic_list_item.dart';
import 'package:blood_center_flutter/features/home/widgets/user_card.dart';
import 'package:blood_center_flutter/models/history.dart';
import 'package:blood_center_flutter/models/user_info.dart';
import 'package:blood_center_flutter/utils/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
            onPressed: () {
              Provider.of<HomeProvider>(context, listen: false).logout(context);
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: (){
          Provider.of<HomeProvider>(context, listen: false).getHistory();
          return Future.delayed(Duration(seconds: 0));
        },
        child: ListView(
          primary: true,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 8),
              child: Text('البيانات الشخصية', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            ),
            UserCard(
              info: info,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 8),
              child: Text('التأريخ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
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
              child: Text(
                'Nothing to show yet',
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget historyList(List<History> list) {
    return Card(
      margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 8,
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return Divider();
        },
        padding: EdgeInsets.all(8),
        shrinkWrap: true,
        primary: false,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              GenericListItem(
                id: 'التاريخ',
                value: DateFormat('E LLL d y H:mm').format(list[index].date),
              ),
              GenericListItem(
                id: 'المركز',
                value: list[index].bloodCenterId,
              ),
            ],
          );
        },
      ),
    );
  }
}
