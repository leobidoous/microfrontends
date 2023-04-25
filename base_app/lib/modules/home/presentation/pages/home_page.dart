import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../core/enums/bottom_nav_bar_type_enum.dart';
import '../controllers/home_controller.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = DM.i.get<HomeController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: const RouterOutlet(),
        bottomNavigationBar: ValueListenableBuilder<BottomNavBarType>(
          valueListenable: controller,
          builder: (context_, type, child) {
            return CustomBottomNavBar(selected: controller.state);
          },
        ),
      ),
    );
  }
}
