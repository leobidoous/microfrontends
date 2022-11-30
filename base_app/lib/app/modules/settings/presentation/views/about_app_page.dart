import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../shared/presentation/widgets/sub_page_app_bar.dart';
import '../stores/about_app_store.dart';

class AboutAppPage extends StatefulWidget {
  const AboutAppPage({Key? key}) : super(key: key);

  @override
  State<AboutAppPage> createState() => _AboutAppPageState();
}

class _AboutAppPageState extends State<AboutAppPage> {
  final store = Modular.get<AboutAppStore>();

  @override
  void initState() {
    super.initState();
    store.getDeviceInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SubPageAppBar(title: 'Sobre o aplicativo'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScopedBuilder(
              store: store,
              onState: (_, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      store.state.appName,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize:
                                Theme.of(context).textTheme.headline5?.fontSize,
                          ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Versão ${store.state.version}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 24),
            Image.asset(
              'assets/images/logos/logo-dark.png',
              // fit: BoxFit.fitWidth,
              width: 126,
              height: 97,
            ),
            const SizedBox(height: 24),
            Text(
              'Copyright © 2022 Matrix Energia.\n'
              'Todos os direitos reservados.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}
