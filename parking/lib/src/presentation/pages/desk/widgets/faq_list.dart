import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../../l10n/translations.dart';
import '../../../../domain/entities/desk/faq_entity.dart';
import '../../../controllers/gen_desk/fetch_faq_controller.dart';
import 'faq_list_item.dart';

class FAQList extends StatefulWidget {
  final ScrollPhysics physics;
  final EdgeInsets padding;
  const FAQList({
    super.key,
    this.physics = const NeverScrollableScrollPhysics(),
    this.padding = EdgeInsets.zero,
  });

  @override
  State<FAQList> createState() => _FAQListState();
}

class _FAQListState extends State<FAQList> {
  final controller = DM.i.get<FetchFAQController>();
  FAQEntity? faqOpened;

  @override
  void initState() {
    super.initState();
    controller.fetchFAQs();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<FAQEntity>>(
      valueListenable: controller,
      builder: (context, state, child) {
        if (controller.isLoading) {
          return const Center(child: GenLoading());
        } else if (controller.hasError) {
          return Center(
            child: RequestError(
              padding: const EdgeInsets.all(16),
              message: controller.error.toString(),
              onPressed: controller.fetchFAQs,
            ),
          );
        } else if (state.isEmpty) {
          return Center(
            child: ListEmpty(
              message: Tr.of(context).noItemAvailable,
              onPressed: controller.fetchFAQs,
              padding: const EdgeInsets.all(16),
            ),
          );
        }
        return ListView.builder(
          itemCount: controller.state.length,
          shrinkWrap: true,
          padding: widget.padding,
          physics: widget.physics,
          itemBuilder: (_, index) {
            return FAQListItem(
              faq: controller.state[index],
              onTap: (faq) {
                setState(() {
                  faqOpened = faq;
                });
              },
              isLast: state[index] == state.last,
              isSelected: faqOpened == state[index],
            );
          },
        );
      },
    );
  }
}
