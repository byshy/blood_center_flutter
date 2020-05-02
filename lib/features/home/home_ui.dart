import 'package:blood_center_flutter/data/local_provider.dart';
import 'package:blood_center_flutter/di.dart';
import 'package:blood_center_flutter/features/home/home_provider.dart';
import 'package:blood_center_flutter/features/home/widgets/generic_list_item.dart';
import 'package:blood_center_flutter/features/home/widgets/user_card.dart';
import 'package:blood_center_flutter/features/map/map_ui.dart';
import 'package:blood_center_flutter/models/blood_center.dart';
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
  GlobalKey<ScaffoldState> _scaffoldKey;
  UserInfo info;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    info = sl<LocalProvider>().getUser().info;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<HomeProvider>(context, listen: false).getHistory();
      Provider.of<HomeProvider>(context, listen: false).getCenters();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
            icon: Icon(Icons.not_listed_location),
            onPressed: () => centersBottomSheet(),
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Provider.of<HomeProvider>(context, listen: false).logout(context);
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          Provider.of<HomeProvider>(context, listen: false).getHistory();
          Provider.of<HomeProvider>(context, listen: false).getCenters();
          return Future.delayed(Duration(seconds: 0));
        },
        child: ListView(
          primary: true,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 8),
              child: Text(
                'البيانات الشخصية',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            UserCard(
              info: info,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 8),
              child: Text(
                'التأريخ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Consumer<HomeProvider>(
              builder: (context, instance, child) {
                if (instance.historyLoading) {
                  return Center(child: LoadingIndicator());
                } else if (instance.historyList.historyList.isNotEmpty &&
                    !instance.historyLoading) {
                  return historyList(instance.historyList.historyList);
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

  void centersBottomSheet() {
    _scaffoldKey.currentState.showBottomSheet(
      (context) => Column(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Container(
            color: Colors.transparent,
            height: 235,
            child: Card(
              clipBehavior: Clip.hardEdge,
              elevation: 16,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Consumer<HomeProvider>(
                builder: (context, instance, child) {
                  if (instance.centersLoading) {
                    return Center(child: LoadingIndicator());
                  } else if (instance.centersList.centersList.isNotEmpty &&
                      !instance.centersLoading) {
                    List<BloodCenter> temp = instance.centersList.centersList;
                    return ListView.separated(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount: temp.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CentersMap(
                                  lat: temp[index].lat,
                                  long: temp[index].long,
                                ),
                              ),
                            );
                          },
                          child: Text(
                            temp[index].name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return child;
                },
                child: Text(
                  'Nothing to show yet',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.transparent,
    );
  }
}
