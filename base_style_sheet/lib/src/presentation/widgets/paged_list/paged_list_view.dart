import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../empties/list_empty.dart';
import '../gen_loading.dart';
import '../request_error.dart';
import 'paged_list_controller.dart';

class PagedListView<S, E> extends StatefulWidget {
  final bool shrinkWrap;
  final EdgeInsets padding;
  final bool initWithRequest;
  final bool safeAreaLastItem;
  final ScrollController? scrollController;
  final PagedListController<S, E> listController;
  final Widget Function(BuildContext, S, int) itemBuilder;
  final Widget Function(BuildContext) separatorBuilder;
  final Widget Function(BuildContext, Function)? noItemsFoundIndicatorBuilder;
  final Widget Function(
    BuildContext,
    E?,
    Function,
  )? newPageErrorIndicatorBuilder;
  final Widget Function(
    BuildContext,
    E?,
    Function,
  )? firstPageErrorIndicatorBuilder;
  final Widget Function(BuildContext)? newPageProgressIndicatorBuilder;
  final Widget Function(BuildContext)? firstPageProgressIndicatorBuilder;

  const PagedListView({
    super.key,
    this.scrollController,
    this.initWithRequest = true,
    this.shrinkWrap = false,
    required this.itemBuilder,
    required this.listController,
    this.safeAreaLastItem = true,
    this.padding = EdgeInsets.zero,
    required this.separatorBuilder,
    this.noItemsFoundIndicatorBuilder,
    this.newPageErrorIndicatorBuilder,
    this.firstPageErrorIndicatorBuilder,
    this.newPageProgressIndicatorBuilder,
    this.firstPageProgressIndicatorBuilder,
  });

  @override
  State<PagedListView<S, E>> createState() => _PagedListViewState<S, E>();
}

class _PagedListViewState<S, E> extends State<PagedListView<S, E>> {
  late final ScrollController scrollController;
  late final PagedListController<S, E> controller;

  @override
  void initState() {
    super.initState();
    scrollController = widget.scrollController ?? ScrollController();
    controller = widget.listController;
    if (widget.initWithRequest) controller.refresh();
  }

  Future<void> _fetchItemsAndScroll() async {
    await controller
        .fetchNewItems(pageKey: controller.config.pageKey)
        .whenComplete(() async {
      /// TODO: criar uma lógica para exibir
      /// a mensagem de erro no final da lista
      if (controller.hasError) {
        const duration = Duration(milliseconds: 250);
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: duration,
          curve: Curves.bounceIn,
        );
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<S>>(
      valueListenable: controller,
      builder: (context, state, child) {
        if (controller.isLoading && state.isEmpty) {
          return widget.firstPageProgressIndicatorBuilder?.call(context) ??
              Center(
                child: Padding(
                  padding: widget.padding,
                  child: const GenLoading(),
                ),
              );
        } else if (controller.hasError && state.isEmpty) {
          return Center(
            child: widget.firstPageErrorIndicatorBuilder?.call(
                  context,
                  (controller.error as E),
                  controller.refresh,
                ) ??
                RequestError(
                  padding: widget.padding,
                  message: controller.error.toString(),
                  onPressed: controller.refresh,
                ),
          );
        } else if (state.isEmpty) {
          return Center(
            child: widget.noItemsFoundIndicatorBuilder?.call(
                  context,
                  controller.refresh,
                ) ??
                ListEmpty(
                  padding: widget.padding,
                  onPressed: controller.refresh,
                  message: 'Nenhum item encontrado.',
                ),
          );
        }
        return NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification is ScrollEndNotification) {
              _fetchItemsAndScroll();
            }
            return true;
          },
          child: RawScrollbar(
            controller: scrollController,
            thumbColor: context.colorScheme.primary,
            radius: const Radius.circular(20),
            child: ListView.builder(
              padding: widget.padding,
              itemCount: state.length,
              shrinkWrap: widget.shrinkWrap,
              reverse: controller.reverse,
              controller: scrollController,
              physics: widget.shrinkWrap
                  ? const NeverScrollableScrollPhysics()
                  : const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
              itemBuilder: (_, index) => _listItem(state, index),
            ),
          ),
        );
      },
    );
  }

  Widget _listItem(List<S> items, int index) {
    return SafeArea(
      top: false,
      bottom: (controller.reverse
              ? items.first == items[index]
              : items.last == items[index]) &&
          widget.safeAreaLastItem,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (controller.reverse)
            if (items.last == items[index]) ..._errorAndLoading,
          widget.itemBuilder(context, items[index], index),
          widget.separatorBuilder(context),
          if (!controller.reverse)
            if (items.last == items[index]) ..._errorAndLoading,
        ],
      ),
    );
  }

  List<Widget> get _errorAndLoading {
    return [
      if (controller.hasError && !controller.isLoading)
        widget.newPageErrorIndicatorBuilder?.call(
              context,
              controller.error,
              _fetchItemsAndScroll,
            ) ??
            RequestError(
              padding: EdgeInsets.zero,
              message: controller.error.toString(),
              onPressed: _fetchItemsAndScroll,
            ),
      if (controller.isLoading)
        widget.newPageProgressIndicatorBuilder?.call(context) ??
            Center(
              child: GenLoading(
                width: const Spacing(3).value,
                height: const Spacing(3).value,
              ),
            ),
    ];
  }
}
