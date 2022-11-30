import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../home/domain/entities/recent_researches_entity.dart';
import '../store/stocks_details_store.dart';

class StocksDetailsPage extends StatefulWidget {
  final RecentResearchesEntity stocks;
  const StocksDetailsPage({super.key, required this.stocks});

  @override
  State<StocksDetailsPage> createState() => _StocksDetailsPageState();
}

class _StocksDetailsPageState extends State<StocksDetailsPage> {
  final store = Modular.get<StocksDetailsStore>();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
          ScopedBuilder.transition(
            store: store,
            onLoading: (context) {
              return const DefaultLoading();
            },
            onError: (context, error) {
              return RequestError(
                message: error.toString(),
              );
            },
            onState: (context, state) {
              
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
