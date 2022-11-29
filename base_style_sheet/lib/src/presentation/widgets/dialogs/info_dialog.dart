import 'package:flutter/material.dart';

import 'default_dialog.dart';

class InfoDialog {
  late final DefaultDialog defaultDialog;

  InfoDialog() {
    defaultDialog = DefaultDialog();
  }
  Future<bool> show(BuildContext context) async {
    return await defaultDialog.show(context, const _InfoDialogWidget()).then(
          (value) => value == true,
        );
  }
}

class _InfoDialogWidget extends StatelessWidget {
  const _InfoDialogWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(),
      ],
    );
  }
}
