import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key, required this.onClose});

  final VoidCallback onClose;

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  late final PageController pageController;
  final stages = [0, 1, 2];
  int selected = 0;

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        automaticallyImplyLeading: Nav.to.canPop(),
        backgroundColor: Colors.transparent,
        actions: [
          AppBarButton(onTap: widget.onClose, child: const Icon(Icons.close))
        ],
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          PageView(
            onPageChanged: (value) {
              setState(() {
                selected = value;
              });
            },
            children: [
              Stack(
                fit: StackFit.expand,
                children: [
                  SizedBox.expand(
                    child: Image.asset(
                      'assets/images/onboarding/onboarding-stage1.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              Stack(
                fit: StackFit.expand,
                children: [
                  SizedBox.expand(
                    child: Image.asset(
                      'assets/images/onboarding/onboarding-stage2.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              Stack(
                fit: StackFit.expand,
                children: [
                  SizedBox.expand(
                    child: Image.asset(
                      'assets/images/onboarding/onboarding-stage3.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(const Spacing(3).value),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: stages
                            .map(
                              (e) => AnimatedDot(
                                callback: () {
                                  setState(() {
                                    selected = stages.indexOf(e);
                                  });
                                  pageController.animateToPage(
                                    stages.indexOf(e),
                                    curve: Curves.decelerate,
                                    duration: const Duration(milliseconds: 250),
                                  );
                                },
                                selected: selected == stages.indexOf(e),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
