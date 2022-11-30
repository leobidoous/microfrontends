import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../shared/presentation/widgets/sub_page_app_bar.dart';

class TalkWithUsPage extends StatefulWidget {
  const TalkWithUsPage({Key? key}) : super(key: key);

  @override
  State<TalkWithUsPage> createState() => _TalkWithUsPageState();
}

class _TalkWithUsPageState extends State<TalkWithUsPage> {
  final textController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SubPageAppBar(title: 'Fale conosco'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Form(
                    key: formKey,
                    child: DefaultTextField(
                      controller: textController,
                      placeholder: 'Descreva o problema ou deixe '
                          'o seu feedback para melhorias ou sugestões.',
                      maxLines: 7,
                      label: 'Comentário',
                      validator: FormValidators.emptyField,
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(height: 16),
                  DefaultButton(
                    text: Text(
                      'Enviar',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        textController.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
