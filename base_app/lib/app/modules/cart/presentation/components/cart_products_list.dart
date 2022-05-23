import 'package:flutter/material.dart';

class CartProductsList extends StatelessWidget {
  const CartProductsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 10,
      shrinkWrap: true,
      padding: const EdgeInsets.all(12),
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, index) {
        return Container(
          height: 75,
          color: Colors.red,
        );
      },
    );
  }
}
