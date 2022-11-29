import 'dart:async';
import 'dart:io';

import 'package:base_style_sheet/base_style_sheet.dart'
    show DefaultAppBar, RequestError, DefaultLoading;
import 'package:core/core.dart'
    show
        Modular,
        WebViewController,
        WebView,
        AndroidWebView,
        CoreIcons,
        ScopedBuilder,
        JavascriptChannel,
        JavascriptMode,
        NavigationRequest,
        NavigationDecision,
        JavascriptMessage;
import 'package:flutter/material.dart'
    show
        StatefulWidget,
        Key,
        State,
        Widget,
        BuildContext,
        Scaffold,
        InkWell,
        Navigator,
        Icon,
        Theme,
        Padding,
        EdgeInsets,
        Center,
        Container,
        BoxDecoration,
        Border,
        BorderSide,
        SafeArea,
        Column,
        CrossAxisAlignment,
        MainAxisAlignment,
        MainAxisSize,
        FutureBuilder,
        Row,
        Expanded,
        SizedBox,
        Icons,
        ScaffoldMessenger,
        SnackBar,
        Text;

import '../../../auth/domain/usecases/microsoft_sso_usecase.dart';
import '../stores/login_url_store.dart';

class MicrosoftLoginPage extends StatefulWidget {
  const MicrosoftLoginPage({Key? key}) : super(key: key);

  @override
  State<MicrosoftLoginPage> createState() => _MicrosoftLoginPageState();
}

class _MicrosoftLoginPageState extends State<MicrosoftLoginPage> {
  final store = LoginUrlStore(store: Modular.get<MicrosoftSSOUsecase>());
  final controller = Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    store.getLoginUrl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        leading: InkWell(
          onTap: Navigator.of(context).pop,
          child: Icon(
            CoreIcons.x,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: ScopedBuilder(
        store: store,
        onError: (context, error) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: RequestError(
              message: 'message',
              onPressed: store.getLoginUrl,
            ),
          );
        },
        onLoading: (context) {
          return const Center(child: DefaultLoading());
        },
        onState: (context, state) {
          return WebView(
            initialUrl: store.state,
            onWebViewCreated: (webViewController) {
              controller.complete(webViewController);
            },
            javascriptMode: JavascriptMode.unrestricted,
            javascriptChannels: <JavascriptChannel>{
              _toasterJavascriptChannel(context),
            },
            navigationDelegate: (NavigationRequest request) {
              final uri = Uri.parse(request.url.replaceFirst('#', '?'));
              if (uri.queryParameters['error'] != null) {
                Navigator.of(context).pop(uri.queryParameters['error']);
              }
              final token = uri.queryParameters['code'];
              if (token != null) {
                Navigator.of(context).pop(token);
              }
              return NavigationDecision.navigate;
            },
          );
        },
      ),
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
          ),
          color: Theme.of(context).backgroundColor,
        ),
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              FutureBuilder<WebViewController>(
                future: controller.future,
                builder: (_, snapshot) {
                  return Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            InkWell(
                              onTap: snapshot.data?.goBack,
                              child: Icon(
                                CoreIcons.chevronLeft,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            const SizedBox(width: 32),
                            InkWell(
                              onTap: snapshot.data?.goForward,
                              child: Icon(
                                CoreIcons.chevronRight,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      InkWell(
                        onTap: snapshot.data?.reload,
                        child: Icon(
                          Icons.refresh_outlined,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
      name: 'Toaster',
      onMessageReceived: (JavascriptMessage message) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message.message)),
        );
      },
    );
  }
}
