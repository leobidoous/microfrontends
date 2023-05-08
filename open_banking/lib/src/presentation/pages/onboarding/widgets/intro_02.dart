import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
   
class Intro02 extends StatelessWidget {

  const Intro02({
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
                  Padding(
                    padding: EdgeInsets.only(
                      left: const Spacing(2).value,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Descomplique sua\nvida financeira',
                          style: context.textTheme.titleLarge?.copyWith(
                            fontFamily: 'Inter',
                            fontWeight: context.textTheme.fontWeightBold,
                          ),
                        ),
                        const Spacing(1).vertical,
                        Column(
                          children: subtitles.map((subtitle) => Padding(
                            padding: EdgeInsets.only(
                              top: const Spacing(3).value,
                            ),
                            child: Row(  
                              children: [
                                Icon(
                                  CoreIcons.checkOutline,
                                  color: AppColorsBase.success3,
                                  size: 20,
                                ),
                                Spacing.sm.horizontal,
                                Text(
                                  subtitle,
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    color: AppColorsBase.neutrla6,
                                    fontWeight: context.textTheme.fontWeightRegular,
                                  ),
                                ),
                              ],
                            ),
                          ),).toList(),
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/images/open_banking/financial.svg',
                  ),
                  const Spacing(1).vertical,
                  CustomButton.text(
                    text: 'Adicionar minha conta',
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

  List<String> get subtitles => [
    'Adicione todas as suas contas\nbancárias em um só lugar',
    'Acompanhe transações, saldos e\ninvestimentos em tempo real',
    'Seus dados protegidos com as\nmelhores tecnologias do mercado',
  ];

}
