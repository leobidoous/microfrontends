import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import '../../../../domain/failures/coupon/coupon_failure.dart';

class SearchPlaceErrorView extends StatelessWidget {
  const SearchPlaceErrorView({super.key, required this.error});
  final ICouponFailure error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        automaticallyImplyLeading: false,
        showDivider: false,
        actions: [
          AppBarButton(
            onTap: () => Nav.to.pop(response: error),
            child: const Icon(Icons.close_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: CustomScrollContent(
                reverse: true,
                padding: EdgeInsets.all(const Spacing(2).value),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SvgPicture.asset(
                      'assets/images/parking/found_place_error.svg',
                      height: const Spacing(15).value,
                    ),
                    Spacing.lg.vertical,
                    Text(
                      'Algo deu errado!',
                      textAlign: TextAlign.center,
                      style: context.textTheme.titleLarge,
                    ),
                    Spacing.md.vertical,
                    Text(
                      '''As informações da loja ou o CNPJ cadastrado não foram encontrados em nosso sistema. Registre um novo cupom fiscal.''',
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: context.textTheme.fontWeightLight,
                      ),
                    ),
                    Spacing.xxxl.vertical,
                    CustomButton.text(
                      onPressed: () => Nav.to.pop(response: error),
                      text: 'Registrar novo cupom',
                    ),
                    Spacing.sm.vertical,
                    CustomButton.iconText(
                      type: ButtonType.background,
                      text: 'Fale conosco',
                      onPressed: () => DM.i.get<ZendeskController>().openChat(),
                      icon: CoreIcons.contactUs,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
