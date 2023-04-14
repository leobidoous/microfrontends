import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../profile_routes.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GenAppBar(
        title: 'Perfil',
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GenScrollContent(
                padding: EdgeInsets.all(const Spacing(2).value),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    GenButton.text(
                      text: 'Meu perfil',
                      onPressed: () {
                        Nav.to.pushNamed(
                          ProfileRoutes.profileDetails.relativePath,
                          forRoot: true,
                        );
                      },
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
