import 'package:core/core.dart';
import 'package:flutter/material.dart';
   
class InstitutionSelectedPage extends StatefulWidget {

  final Map institution;
  
  const InstitutionSelectedPage({
    Key? key,
    required this.institution,
  }) : super(key: key);

  @override
  _InstitutionSelectedPageState createState() => _InstitutionSelectedPageState();
}

class _InstitutionSelectedPageState extends State<InstitutionSelectedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Open Banking',
           style: context.textTheme.bodyMedium?.copyWith(
            fontFamily: 'Inter',
            fontWeight: context.textTheme.fontWeightRegular,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Nav.to.pop(),
          icon: Icon(
            CoreIcons.leftOutline,
            size: const Spacing(2).value,
          ),
        ),
        backgroundColor: context.colorScheme.background,
      ),
      body: Container(),
    );
  }
}