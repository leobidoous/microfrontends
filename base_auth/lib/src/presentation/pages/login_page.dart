import 'dart:ui';

import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/login_email_entity.dart';
import '../controllers/login_controller.dart';

class LoginPage extends StatefulWidget {
  final BasePath redirectTo;
  final Future<Either<Exception, UserEntity>> Function(TokenEntity)
      onLoginCallback;
  const LoginPage({
    super.key,
    required this.redirectTo,
    required this.onLoginCallback,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final controller = DM.i.get<LoginController>();
  final formKey = GlobalKey<FormState>();
  final passwordFocus = FocusNode();
  final emailFocus = FocusNode();
  bool showPassword = false;

  @override
  void initState() {
    super.initState();
    emailController.text = 'thiago08@mail.com';
    passwordController.text = '123456';
  }

  @override
  void dispose() {
    emailFocus.dispose();
    passwordFocus.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _onLogin() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    final data = LoginEmailEntity(
      email: emailController.text,
      password: passwordController.text,
    );
    await controller
        .loginWithEmail(data, widget.onLoginCallback)
        .then((value) async {
      if (controller.state) {
        Nav.to.navigate(widget.redirectTo.completePath);
      } else {
        await DefaultDialog().error(
          context,
          message: controller.error.toString(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const DefaultImage(
          url: 'https://picsum.photos/id/58/500/1000',
          fit: BoxFit.fitHeight,
        ),
        Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      color: context.colorScheme.background.withOpacity(.9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.all(16),
                    child: _loginForm,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ValueListenableBuilder(
                    valueListenable: controller,
                    builder: (_, state, child) {
                      return Button(
                        isLoading: controller.isLoading,
                        onPressed: _onLogin,
                        child: Text(
                          'Entrar',
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget get _loginForm {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DefaultTextField(
              controller: emailController,
              label: 'E-mail',
              placeholder: 'Informe seu e-mail',
              prefix: Icons.email_rounded,
              focus: emailFocus,
              keyboardType: TextInputType.emailAddress,
              onFieldSubmitted: (input) {
                passwordFocus.requestFocus();
              },
              validators: const [
                FormValidators.emptyField,
                FormValidators.invalidEmail,
              ],
              inputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),
            DefaultTextField(
              controller: passwordController,
              label: 'Senha',
              focus: passwordFocus,
              onSuffixTap: () {
                setState(() {
                  showPassword = !showPassword;
                });
              },
              onFieldSubmitted: (input) {
                FocusScope.of(context).requestFocus(FocusNode());
                _onLogin();
              },
              validators: [
                FormValidators.emptyField,
                (input) {
                  return FormValidators.invalidLength(input, 6);
                }
              ],
              isObscure: !showPassword,
              suffix: showPassword
                  ? Icons.visibility_off_rounded
                  : Icons.visibility_rounded,
              placeholder: 'Informe sua senha',
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
