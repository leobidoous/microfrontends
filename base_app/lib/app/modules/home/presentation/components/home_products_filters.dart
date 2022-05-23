import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../stores/home_store.dart';

class HomeProductsFilters extends StatefulWidget {
  const HomeProductsFilters({Key? key}) : super(key: key);

  @override
  State<HomeProductsFilters> createState() => _HomeProductsFiltersState();
}

class _HomeProductsFiltersState extends State<HomeProductsFilters>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final store = Modular.get<HomeStore>().productsStore;
  final textController = TextEditingController();
  final duration = const Duration(milliseconds: 250);
  late final AnimationController controller;
  late final Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: duration);
    animation = Tween<double>(begin: 0, end: 1).animate(controller);
  }

  @override
  void dispose() {
    textController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AnimatedBuilder(
      animation: animation,
      builder: (_, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  if (controller.isCompleted) {
                    controller.reverse();
                  } else {
                    controller.forward();
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 4),
                  child: AnimatedSwitcher(
                    duration: duration,
                    transitionBuilder: (child, _) {
                      final _in = Tween<double>(
                        begin: 1,
                        end: 0,
                      ).animate(controller);
                      final _out = Tween<double>(
                        begin: 0,
                        end: 1,
                      ).animate(controller);
                      if (child.key == const ValueKey(1)) {
                        return FadeTransition(
                          opacity: _out,
                          child: const Icon(Icons.arrow_forward_ios_rounded),
                        );
                      }
                      return FadeTransition(
                        opacity: _in,
                        child: const Icon(Icons.search_rounded),
                      );
                    },
                    child: SizedBox(
                      key: ValueKey(controller.isCompleted ? 1 : 0),
                    ),
                  ),
                ),
              ),
              Flexible(
                child: SizeTransition(
                  sizeFactor: animation,
                  axis: Axis.horizontal,
                  child: FadeTransition(
                    opacity: animation,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 4),
                      child: DefaultTextFieldWidget(
                        controller: textController,
                        onComplete: (input) {
                          store.params.q = input;
                          store.getProducts();
                        },
                        placeholder: 'Informe o nome do produto',
                        label: 'Buscar',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
