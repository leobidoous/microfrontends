import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class Intro01 extends StatelessWidget {
  
  const Intro01({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final Function() onPressed;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, viewerportConstraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: viewerportConstraints.maxHeight,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: const Spacing(3).value,
                vertical: const Spacing(4).value,
              ),
              child: Column(  
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: const Spacing(3).value,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: SvgPicture.asset(
                          'assets/images/open_banking/financial_health.svg',
                          height: 200.0,
                        ),
                      ),
                      const Spacing(8).vertical,
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: const Spacing(3).value,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Revolucione sua\nexperiência financeira',
                              style: context.textTheme.titleLarge?.copyWith(
                                fontFamily: 'Inter',
                                fontWeight: context.textTheme.fontWeightBold,
                              ),
                            ),
                            const Spacing(2).vertical,
                            Text(
                              'Conecte suas contas bancárias de\nforma segura e fácil com a\nplataforma Gen',
                               style: context.textTheme.bodyMedium?.copyWith(
                                color: AppColorsBase.grey20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  CustomButton.text(
                    text: 'Quero começar',
                    onPressed: onPressed,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
