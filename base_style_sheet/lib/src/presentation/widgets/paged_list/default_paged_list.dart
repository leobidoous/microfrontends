import 'package:flutter/material.dart';

import '../empty/list_empty.dart';
import '../errors/request_error.dart';
import '../loadings/default_loading.dart';
import 'list_controller.dart';

class DefaultPagedList<S, E> extends StatefulWidget {
  final EdgeInsets padding;
  final bool safeAreaLastItem;
  final ScrollController? scrollController;
  final ListController<S, E> listController;
  final Widget Function(BuildContext, S, int) itemBuilder;
  final Widget Function(BuildContext, int) separatorBuilder;
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

  const DefaultPagedList({
    super.key,
    this.scrollController,
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
  State<DefaultPagedList<S, E>> createState() => _DefaultPagedListState<S, E>();
}

class _DefaultPagedListState<S, E> extends State<DefaultPagedList<S, E>> {
  final scrollController = ScrollController();
  late final ListController<S, E> store;

  @override
  void initState() {
    super.initState();
    store = widget.listController;
    store.refresh();

    scrollController.addListener(() {
      _listListener(scrollController);
    });
    widget.scrollController?.addListener(() {
      _listListener(widget.scrollController!);
    });
  }

  void _listListener(ScrollController controller) {
    final max = controller.position.maxScrollExtent;
    final offsetPercent = controller.offset / max * 100;
    if (offsetPercent >= store.searchPercent &&
        !store.isLoading &&
        store.state.isNotEmpty &&
        store.error == null) {
      store.fetchNewItems(offset: store.state.length);
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<S>>(
      valueListenable: store,
      builder: (context, state, child) {
        if (store.isLoading && state.isEmpty) {
          return widget.firstPageProgressIndicatorBuilder?.call(context) ??
              const Center(child: DefaultLoading());
        } else if (store.error != null && state.isEmpty) {
          return _scrollBody(
            child: widget.firstPageErrorIndicatorBuilder?.call(
                  context,
                  store.error,
                  store.refresh,
                ) ??
                RequestError(
                  message: store.error.toString(),
                  onPressed: () async {
                    await store.refresh();
                  },
                ),
          );
        } else if (state.isEmpty) {
          return _scrollBody(
            child: widget.noItemsFoundIndicatorBuilder?.call(
                  context,
                  store.refresh,
                ) ??
                ListEmpty(
                  message: 'Nenhum item encontrado.',
                  onPressed: store.refresh,
                ),
          );
        }
        return ListView.builder(
          padding: widget.padding,
          itemCount: state.length,
          controller: widget.scrollController ?? scrollController,
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          itemBuilder: (context, index) {
            return SafeArea(
              top: false,
              bottom: state.last == state[index] && widget.safeAreaLastItem,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  widget.itemBuilder(context, state[index], index),
                  widget.separatorBuilder(context, index),
                  if (state.last == state[index]) ...[
                    if (store.error != null && !store.isLoading)
                      widget.newPageErrorIndicatorBuilder?.call(
                            context,
                            store.error,
                            () => store.fetchNewItems(offset: state.length),
                          ) ??
                          RequestError(
                            message: store.error.toString(),
                            onPressed: () async {
                              store.fetchNewItems(offset: state.length);
                            },
                          ),
                    if (store.isLoading)
                      widget.newPageProgressIndicatorBuilder?.call(context) ??
                          const Center(
                            child: DefaultLoading(width: 10, height: 10),
                          ),
                  ],
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _scrollBody({required Widget child}) {
    return LayoutBuilder(
      builder: (context, constrains) {
        return SingleChildScrollView(
          padding: widget.padding,
          controller: widget.scrollController,
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          child: SizedBox(
            height: constrains.maxHeight,
            child: Center(child: child),
          ),
        );
      },
    );
  }
}
