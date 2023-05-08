import 'package:core/core.dart';
import 'package:flutter/material.dart';

import './widgets/intro_01.dart';
import './widgets/intro_02.dart';
import '../../../../open_banking.dart';
    
class OnboardingPage extends StatelessWidget {

  const OnboardingPage({ Key? key }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
   
    final PageController controller = PageController();

    return PageView.builder(
      controller: controller,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return Intro01(
              onPressed: () => controller.nextPage(
                duration: const Duration(
                  milliseconds: 1,
                ),
                curve: Curves.bounceIn,
              ),
            );
          case 1:
            return Intro02(
              onPressed: () => Nav.to.pushNamed(
                OpenBankingRoutes.institutionList,
                arguments: true,
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}