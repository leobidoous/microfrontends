import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class ProfileDetailsPage extends StatefulWidget {
  const ProfileDetailsPage({super.key});

  @override
  State<ProfileDetailsPage> createState() => _ProfileDetailsPageState();
}

class _ProfileDetailsPageState extends State<ProfileDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenAppBar(
        title: 'Meu perfil',
        automaticallyImplyLeading: Navigator.of(context).canPop(),
        // onBackTap: Navigator.of(context).pop,
        onBackTap: Nav.to.pop,
      ),
    );
  }
}
