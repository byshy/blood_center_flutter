import 'package:blood_center_flutter/data/local_provider.dart';
import 'package:blood_center_flutter/features/home/home_provider.dart';
import 'package:blood_center_flutter/features/home/home_ui.dart';
import 'package:blood_center_flutter/features/login/login_provider.dart';
import 'package:blood_center_flutter/features/login/login_ui.dart';
import 'package:flutter/material.dart';
import 'package:blood_center_flutter/di.dart' as di;
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blood Center',
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child,
        );
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var firstLaunch = di.sl<LocalProvider>().getIsFirstLaunch();
    return firstLaunch == true || firstLaunch == null
        ? ChangeNotifierProvider(
            child: LoginUI(),
            create: (_) => LoginProvider(),
          )
        : ChangeNotifierProvider(
            child: HomeUI(),
            create: (_) => HomeProvider(),
          );
  }
}
