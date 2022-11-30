import 'package:core/core.dart' show BasePath;
import 'package:flutter/material.dart'
    show
        StatefulWidget,
        Key,
        State,
        Widget,
        BuildContext,
        Container,
        BoxDecoration,
        Colors,
        DecorationImage,
        AssetImage,
        BoxFit,
        Scaffold,
        AppBar;

import '../widgets/fake_login_widget.dart';

class LoginPage extends StatefulWidget {
  final BasePath loginFoward;
  const LoginPage({Key? key, required this.loginFoward}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          image: AssetImage(
            'assets/images/space_background.png',
            package: 'core',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        bottomNavigationBar: FakeLogin(loginFoward: widget.loginFoward),
      ),
    );
  }
}
