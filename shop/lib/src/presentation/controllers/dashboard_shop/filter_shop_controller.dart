import 'package:core/core.dart';
import 'package:flutter/material.dart';

class FilterShopController extends GenController<Exception, void> {
  FilterShopController() : super([]);

  final GlobalKey<FormFieldState> sortingFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> brandsFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> mallsFormKey = GlobalKey<FormFieldState>();
  String option = '';
  String brand = '';
  String mall = '';

  Map<String, String> filterMap() {
    var map = <String, String>{};

    if (mall != '') {
      map.addAll({'mall': mall});
    }

    if (brand != '') {
      map.addAll({'brand': brand});
    }

    return map;
  }

  Map<String, String> orderByMap() {
    var map = <String, String>{};

    if (option == '' || option == 'Mais relevantes') {
      map.addAll({'orderBy': 'relevance'});
    } else {
      map.addAll({'orderBy': 'display_name'});
      map.addAll({'sortingOrder': 'ASC'});
    }

    return map;
  }
}
