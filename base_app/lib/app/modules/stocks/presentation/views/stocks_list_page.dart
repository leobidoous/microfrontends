import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../home/domain/entities/recent_researches_entity.dart';
import '../../domain/entities/stocks_entity.dart';
import '../stocks_routes.dart';
import '../store/stocks_list_store.dart';
import '../widgets/stocks_list_item.dart';

class StocksListPage extends StatefulWidget {
  final RecentResearchesEntity recent;
  const StocksListPage({super.key, required this.recent});

  @override
  State<StocksListPage> createState() => _StocksListPageState();
}

class _StocksListPageState extends State<StocksListPage> {
  final store = Modular.get<StocksListStore>();

  @override
  void initState() {
    super.initState();
    store.list(term: widget.recent.term);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onTapStocksItem(StocksEntity stocks) async {
    Navigator.of(context).pushNamed(
      StocksRoutes.stocksDetails.completePath,
      arguments: stocks,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        automaticallyImplyLeading: true,
        title: Text(
          'Resultados',
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ScopedBuilder<StocksListStore, HttpDriverResponse,
              List<StocksEntity>>.transition(
            store: store,
            onLoading: (context) {
              return const DefaultLoading();
            },
            onError: (context, error) {
              return RequestError(
                message: error.toString(),
                onPressed: () => store.list(term: widget.recent.term),
              );
            },
            onState: (context, state) {
              if (state.isEmpty) {
                return const ListEmpty(
                  message: 'Nenhuma busca recente realizada.',
                );
              }
              return ListView.separated(
                itemCount: state.length,
                padding: const EdgeInsets.all(16),
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (_, index) {
                  return StocksListItem(
                    recent: state[index],
                    onTapItem: _onTapStocksItem,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
