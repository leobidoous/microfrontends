import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/recent_researches_entity.dart';
import '../home_routes.dart';
import '../stores/home_store.dart';
import '../stores/recent_researches_store.dart';
import '../widgets/recent_researches_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final textController = TextEditingController(text: 'PETR4.SA');
  final scrollController = ScrollController();
  final homeStore = Modular.get<HomeStore>();
  final recentResearchesStore = Modular.get<RecentResearchesStore>();

  @override
  void initState() {
    super.initState();
    recentResearchesStore.getList();
  }

  @override
  void dispose() {
    scrollController.dispose();
    textController.dispose();
    super.dispose();
  }

  Future<void> _onSearch() async {
    if (textController.text.isEmpty) return;
    FocusScope.of(context).requestFocus();
    final recent = RecentResearchesEntity(
      term: textController.text,
      createdAt: DateTime.now(),
    );
    _onTapRecentItem(recent);
    await recentResearchesStore.getList();
  }

  void _onTapRecentItem(RecentResearchesEntity recent) async {
    Navigator.of(context).pushNamed(
      HomeRoutes.stocks.completePath,
      arguments: recent,
    );
    await recentResearchesStore.save(recent: recent);
  }

  void _onRemoveItem(RecentResearchesEntity recent) {
    recentResearchesStore.remove(recent: recent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: TripleBuilder(
              store: homeStore,
              builder: (_, triple) {
                return Opacity(
                  opacity: triple.isLoading ? 0.5 : 1,
                  child: IgnorePointer(
                    ignoring: triple.isLoading,
                    child: DefaultTextField(
                      key: ObjectKey(triple.isLoading),
                      controller: textController,
                      autocorrect: false,
                      label: 'Código do Ativo',
                      placeholder: 'Ex.: PETR4.SA',
                      suffix: Icons.search,
                      onSuffixTap: _onSearch,
                      onComplete: (input) => _onSearch(),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ScopedBuilder<RecentResearchesStore, Exception,
                List<RecentResearchesEntity>>.transition(
              store: recentResearchesStore,
              onLoading: (context) {
                return const DefaultLoading();
              },
              onError: (context, error) {
                return RequestError(
                  message: error.toString(),
                  onPressed: recentResearchesStore.getList,
                );
              },
              onState: (context, state) {
                if (state.isEmpty) {
                  return const ListEmpty(
                    message: 'Nenhuma busca recente realizada.',
                  );
                }
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child: Text(
                        'Buscas recentes',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    Divider(
                      color: Theme.of(context).textTheme.bodyText1?.color,
                      thickness: .1,
                      height: 0,
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemCount: state.length,
                        padding: const EdgeInsets.all(16),
                        physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics(),
                        ),
                        separatorBuilder: (_, __) => const SizedBox(height: 16),
                        itemBuilder: (_, index) {
                          return RecentResearchesItem(
                            recent: state[index],
                            onRemove: _onRemoveItem,
                            onTapItem: _onTapRecentItem,
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
