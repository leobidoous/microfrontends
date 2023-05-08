import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/Institution_entity.dart';
import '../../../domain/usecase/institution/i_institution_usecase.dart';

class InstitutionController 
  extends GenController<Exception, List<InstitutionEntity>>{

  InstitutionController({
    required this.usecase,
  }) : super([]);

  final IInstitutionUsecase usecase;

  Future<void>fetchBankList() async {
    await execute(() => usecase.fetchBankList());
    bankList.value = state;
  }
  
  ValueNotifier<List<InstitutionEntity>> bankList = ValueNotifier([]);

  getBankByName(String value) {
     if(value != '') {
      List<InstitutionEntity> foundList = [];
      state.forEach((element) {
        element.displayName.split(' ').forEach((e) { 
          final search = value.toLowerCase().replaceAll(' ', '');
          final name = e.toLowerCase()
          .replaceAll(' ', '')
          .split('');
          String comparison = '';
          for(var i = 0; i < search.length; i++) {
            if(name.length >= search.length) {
              comparison = comparison + name[i];
            } else {
              continue;
            }
          }  
          if(search == comparison) {
            foundList.add(element);
          }
        });
      });
      if(foundList.isNotEmpty) {
        bankList.value = foundList;
      } else {
        bankList.value = [];
      }
    } else {
      return bankList.value = state;
    }
  }

  clenSearchInput() {
    bankList.value = state;
  }
  
  Map institution = {};

}