import 'package:base_style_sheet/base_style_sheet.dart'
    show DefaultDialog, DefaultLoading;
import 'package:core/core.dart' show BasePath, Modular, TripleBuilder;
import 'package:flutter/material.dart'
    show
        StatefulWidget,
        State,
        Key,
        showGeneralDialog,
        Widget,
        BuildContext,
        Opacity,
        AbsorbPointer,
        Text,
        Column,
        Row,
        Container,
        SizedBox,
        MainAxisAlignment,
        Flexible,
        SafeArea,
        TextButton,
        Builder,
        MainAxisSize,
        Clip,
        BoxDecoration,
        Theme,
        BorderRadius,
        Radius,
        ButtonStyle,
        Size,
        MaterialStatePropertyAll,
        MaterialTapTargetSize,
        VisualDensity,
        Colors,
        TextOverflow,
        BoxShape,
        Image,
        ThemeData,
        TextTheme,
        DecoratedBox;

import '../stores/microsoft_login_store.dart';
import '../views/microsoft_login_page.dart';

class SocialLogin extends StatefulWidget {
  final BasePath loginFoward;
  const SocialLogin({Key? key, required this.loginFoward}) : super(key: key);

  @override
  State<SocialLogin> createState() => _SocialLoginState();
}

class _SocialLoginState extends State<SocialLogin> {
  final store = Modular.get<MicrosoftLoginStore>();

  void login() async {
    await showGeneralDialog<String?>(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return const MicrosoftLoginPage();
      },
    ).then((value) async {
      if (value == null) return;
      await store.login(code: value).then((value) {
        if (store.state) {
          Modular.to.navigate(widget.loginFoward.completePath);
        } else {
          DefaultDialog().error(
            context,
            message: '${store.error?.statusMessage}',
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TripleBuilder(
      store: store,
      builder: (_, triple) {
        return Opacity(
          opacity: triple.isLoading ? 0.5 : 1,
          child: AbsorbPointer(
            absorbing: triple.isLoading,
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: _themData.colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: SafeArea(
                child: TextButton(
                  onPressed: login,
                  style: ButtonStyle(
                    visualDensity: VisualDensity.compact,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minimumSize: const MaterialStatePropertyAll(
                      Size(double.infinity, 60),
                    ),
                    overlayColor: const MaterialStatePropertyAll(
                      Colors.transparent,
                    ),
                    surfaceTintColor: const MaterialStatePropertyAll(
                      Colors.transparent,
                    ),
                    foregroundColor: const MaterialStatePropertyAll(
                      Colors.transparent,
                    ),
                    backgroundColor: MaterialStatePropertyAll(
                      _themData.colorScheme.primary,
                    ),
                  ),
                  child: SafeArea(
                    top: false,
                    child: Builder(
                      builder: (context) {
                        if (triple.isLoading) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              DefaultLoading(width: 10, height: 10),
                            ],
                          );
                        }
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DecoratedBox(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _themData.backgroundColor,
                              ),
                              child: Image.asset(
                                'assets/images/logos/microsoft_logo.png',
                                package: 'base_auth',
                                height: 30,
                                width: 30,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Flexible(
                              child: Text(
                                'Login com Microsoft',
                                overflow: TextOverflow.ellipsis,
                                style: _textTheme.bodyText2,
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  ThemeData get _themData => Theme.of(context);
  TextTheme get _textTheme => _themData.textTheme;
}
