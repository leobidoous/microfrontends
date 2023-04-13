import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'controllers/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = DM.i.get<HomeController>();
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenAppBar(
        title: 'Início',
        actions: [
          InkWell(
            onTap: () {
              controller.sessionController.logout();
            },
            child: const Icon(Icons.exit_to_app_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: GenScrollContent(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                SessionModel.fromEntity(controller.sessionController.state)
                    .toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
