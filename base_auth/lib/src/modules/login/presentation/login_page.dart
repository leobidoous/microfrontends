import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart' show Modular, TripleBuilder;
import 'package:flutter/material.dart';

import '../../../core/enums/login_type.dart';
import 'stores/login_store.dart';

class LoginPage extends StatefulWidget {
  final String loginFoward;
  const LoginPage({Key? key, required this.loginFoward}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginStore store = Modular.get<LoginStore>();
  final identify = TextEditingController(text: 'leonardo@bido.com');
  final password = TextEditingController();

  @override
  void dispose() {
    identify.dispose();
    password.dispose();
    super.dispose();
  }

  void login() {
    store
        .login(
      identify: identify.text.trim(),
      password: password.text,
    )
        .then((value) {
      if (store.state) {
        Modular.to.pushReplacementNamed(widget.loginFoward);
      } else {
        DefaultDialog().show(
          context,
          Text(store.error.toString()),
          showClose: true,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TripleBuilder(
                    store: store.typeStore,
                    builder: (_, triple) {
                      late final String label;
                      switch (store.typeStore.state) {
                        case LoginType.email:
                          label = 'Email';
                          break;
                        case LoginType.phone:
                          label = 'Phone';
                          break;
                      }
                      return DefaultTextFieldWidget(
                        controller: identify,
                        label: label,
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  DefaultTextFieldWidget(
                    controller: password,
                    label: 'Password',
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: TripleBuilder(
              store: store,
              builder: (_, triple) {
                return DefaultButtonWidget(
                  text: 'Login',
                  onPressed: login,
                  isLoading: store.isLoading,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
