import 'dart:io';

import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../controllers/ticket_window/ocr_recognizer_controller.dart';
import '../../controllers/ticket_window/review_photos_controller.dart';
import '../../routes/ticket_window_routes.dart';
import 'widgets/photo_list_item.dart';

class ReviewPhotosPage extends StatefulWidget {
  const ReviewPhotosPage({super.key, required this.file});

  final File file;

  @override
  State<ReviewPhotosPage> createState() => _ReviewPhotosPageState();
}

class _ReviewPhotosPageState extends State<ReviewPhotosPage> {
  final controller = DM.i.get<ReviewPhotosController>();
  final ocrController = DM.i.get<OcrRecognizerController>();

  @override
  void initState() {
    super.initState();
    controller.onAddValue(widget.file);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenAppBar.zero(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            const Spacing(2).value,
            const Spacing(5).value,
            const Spacing(2).value,
            const Spacing(2).value,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Spacing.sm.vertical,
              Text(
                'Envie as fotos dos cupons fiscais:',
                textAlign: TextAlign.center,
                style: context.textTheme.titleMedium?.copyWith(
                  fontSize: 18,
                  fontWeight: context.textTheme.fontWeightRegular,
                ),
              ),
              Spacing.xxxl.vertical,
              Expanded(
                child: ValueListenableBuilder<List<File>>(
                  valueListenable: controller,
                  builder: (context, state, child) {
                    return ListView.separated(
                      padding: EdgeInsets.zero,
                      itemCount: state.length,
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      separatorBuilder: (_, __) => Spacing.sm.vertical,
                      itemBuilder: (_, index) => PhotoListItem(
                        file: state[index],
                        onRemove: (value) {
                          controller.onRemoveValue(value);
                          if (controller.state.isEmpty) Nav.to.pop();
                        },
                      ),
                    );
                  },
                ),
              ),
              Spacing.sm.vertical,
              ValueListenableBuilder<List<File>>(
                valueListenable: ocrController,
                builder: (context, state, child) {
                  return GenButton.text(
                    onPressed: () {
                      ocrController
                          .recognizePhotos(controller.state)
                          .then((value) {
                        Nav.to.pushNamed(
                          TicketWindowRoutes.enterCouponManually,
                          arguments: controller.state,
                        );
                      });
                    },
                    isLoading: ocrController.isLoading,
                    text: 'Continuar',
                  );
                },
              ),
              Spacing.sm.vertical,
              GenButton.text(
                onPressed: Nav.to.pop,
                text: 'Enviar mais cupons',
                type: ButtonType.background,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
