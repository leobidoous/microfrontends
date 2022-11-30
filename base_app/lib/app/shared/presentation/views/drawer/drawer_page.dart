import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../stores/user_store.dart';

class DrawerPage extends StatelessWidget {
  final userStore = Modular.get<UserStore>();

  DrawerPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .85,
      child: Scaffold(
        appBar: const DefaultAppBar(
          automaticallyImplyLeading: true,
          title: Icon(CoreIcons.home),
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        body: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF2A2A2A).withOpacity(0.5),
                    spreadRadius: -1.5,
                    blurRadius: 5,
                  ),
                ],
                color: Theme.of(context).colorScheme.secondary,
                border: Border(
                  right: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                ),
              ),
              width: 16,
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
