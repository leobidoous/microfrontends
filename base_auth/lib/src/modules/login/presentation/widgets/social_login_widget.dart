import 'package:base_style_sheet/base_style_sheet.dart'
    show DefaultDialog, DefaultLoading;
import 'package:core/core.dart' show BasePath, Modular, TripleBuilder;
import 'package:flutter/material.dart'
    show
        AbsorbPointer,
        BorderRadius,
        BoxDecoration,
        BoxShape,
        BuildContext,
        Builder,
        ButtonStyle,
        Clip,
        Colors,
        Column,
        Container,
        DecoratedBox,
        Flexible,
        Icon,
        Icons,
        Key,
        MainAxisAlignment,
        MainAxisSize,
        MaterialStatePropertyAll,
        MaterialTapTargetSize,
        Opacity,
        Radius,
        Row,
        SafeArea,
        Size,
        SizedBox,
        State,
        StatefulWidget,
        Text,
        TextButton,
        TextOverflow,
        TextTheme,
        Theme,
        ThemeData,
        VisualDensity,
        Widget,
        showGeneralDialog;

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
                              child: Icon(
                                Icons.abc,
                                color: _themData.colorScheme.onBackground,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Flexible(
                              child: Text(
                                'Entrar',
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
