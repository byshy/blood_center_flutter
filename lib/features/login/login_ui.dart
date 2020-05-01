import 'package:blood_center_flutter/utils/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_provider.dart';

class LoginUI extends StatefulWidget {
  @override
  _LoginUIState createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  GlobalKey<ScaffoldState> _scaffoldKey;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _pass = FocusNode();

  bool _validateEmail = false;
  bool _validatePassword = false;
  bool _hidePass = true;
  bool _enableSignIn = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var _user = Provider.of<LoginProvider>(context).user;
    if (_user != null) {
      if (_user.info == null) {
        print('error in login ui didChangeDependencies');
//        _scaffoldKey.currentState.showSnackBar(
//          SnackBar(
//            content: Text(_user.msg),
//          ),
//        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    _emailController.text = 'baselhadrous99@gmail.com';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'تسجيل الدخول',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'أهلا بك',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            'أدخل البريد الالكتروني',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 7,
          ),
          TextField(
            controller: _emailController,
            textAlign: TextAlign.end,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            onChanged: (str) {
              if (str.isNotEmpty) {
                setState(() {
                  _validateEmail = false;
                  if (_passwordController.text.isNotEmpty) {
                    _enableSignIn = true;
                  }
                });
              } else {
                setState(() {
                  _validateEmail = true;
                  _enableSignIn = false;
                });
              }
            },
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(_pass);
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(8.0),
              hintText: 'email123@gmail.com',
              errorText: _validateEmail ? 'Email Can\'t Be Empty' : null,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'كلمة المرور',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 7,
          ),
          TextField(
            obscureText: _hidePass,
            controller: _passwordController,
            textAlign: TextAlign.end,
            focusNode: _pass,
            onChanged: (str) {
              if (str.isNotEmpty) {
                setState(() {
                  _validatePassword = false;
                  if (_emailController.text.isNotEmpty) {
                    _enableSignIn = true;
                  }
                });
              } else {
                setState(() {
                  _validatePassword = true;
                  _enableSignIn = false;
                });
              }
            },
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(new FocusNode());
              if(_passwordController.text.isNotEmpty && _emailController.text.isNotEmpty){
                login();
              }
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(8.0),
              errorText: _validatePassword ? 'Password Can\'t Be Empty' : null,
              prefixIcon: IconButton(
                icon: _hidePass
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.visibility),
                onPressed: () {
                  setState(() {
                    _hidePass = !_hidePass;
                  });
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: RaisedButton(
              color: Colors.blue,
              onPressed: _enableSignIn
                  ? () {
                login();
              }
                  : null,
              child: Consumer<LoginProvider>(
                builder: (context, login, child) {
                  if (login.logInLoading) {
                    return LoadingIndicator();
                  }
                  return child;
                },
                child: Text(
                  'تسجيل الدخول',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  login() {
    Provider.of<LoginProvider>(context, listen: false).login(
      context,
      data: {
        'username': _emailController.text,
        'password': _passwordController.text,
      },
    );
  }
}
