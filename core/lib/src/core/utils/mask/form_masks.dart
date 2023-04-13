import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class FormMasks {
  static TextInputFormatter cpf() {
    return MaskTextInputFormatter(
      mask: '###.###.###-##',
      filter: {'#': RegExp(r'\d')},
    );
  }

  static TextInputFormatter cnpj() {
    return MaskTextInputFormatter(
      mask: '##.###.###/####-##',
      filter: {'#': RegExp(r'\d')},
    );
  }

  static TextInputFormatter phone() {
    return MaskTextInputFormatter(
      mask: '(##) # ####-####',
      filter: {'#': RegExp(r'\d')},
    );
  }

  static TextInputFormatter date() {
    return MaskTextInputFormatter(
      mask: '##/##/####',
      filter: {'#': RegExp(r'\d')},
    );
  }

  static TextInputFormatter creditCard() {
    return MaskTextInputFormatter(
      mask: '#### #### #### ####',
      filter: {'#': RegExp(r'\d')},
    );
  }

  static TextInputFormatter zipCode() {
    return MaskTextInputFormatter(
      mask: '##.###-###',
      filter: {'#': RegExp(r'\d')},
    );
  }

  static TextInputFormatter cvc() {
    return MaskTextInputFormatter(
      mask: '####',
      filter: {'#': RegExp(r'\d')},
    );
  }

  static TextInputFormatter creditCardExpirationDate() {
    return MaskTextInputFormatter(
      mask: '##/##',
      filter: {'#': RegExp(r'\d')},
    );
  }

  static TextInputFormatter currency() {
    return MaskTextInputFormatter(
      mask: '${'#.###' * 10},##',
      filter: {'#': RegExp(r'\d')},
    );
  }

  static TextInputFormatter plate() {
    return MaskTextInputFormatter(
      mask: '###-####',
      filter: {'#': RegExp(r'[0-9A-Za-z]')},
    );
  }
}
