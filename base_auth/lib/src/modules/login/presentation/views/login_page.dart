import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart' show BasePath, CoreIcons;
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
        AppBar,
        Column,
        CrossAxisAlignment,
        SizedBox,
        MediaQuery,
        Expanded,
        Image,
        InkWell,
        Row,
        Icon,
        MainAxisAlignment,
        Flexible,
        Text,
        Theme;

import '../widgets/social_login_widget.dart';

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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .25),
            Expanded(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/logos/logo_icon.png',
                    package: 'base_auth',
                  ),
                  Image.asset(
                    'assets/images/logos/logo_name.png',
                    package: 'base_auth',
                  ),
                ],
              ),
            ),
            _buildFooter,
            const SizedBox(height: 16),
          ],
        ),
        bottomNavigationBar: SocialLogin(loginFoward: widget.loginFoward),
      ),
    );
  }

  Widget get _buildFooter {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 8),
        Image.asset(
          'assets/images/logos/logo_footer.png',
          package: 'base_auth',
          height: 16,
        ),
        const SizedBox(height: 16),
        InkWell(
          onTap: () {
            DefaultDialog().show(
              context,
              const DefaultPDF(url: ''),
              showClose: true,
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  'Políticas de uso',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: Theme.of(context).colorScheme.background,
                      ),
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                CoreIcons.informationCircle,
                color: Theme.of(context).colorScheme.background,
                size: 16,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
