import 'package:credit_card_validator/credit_card_validator.dart';

import 'cnpj_validator.dart';
import 'cpf_validator.dart';

class FormValidators {
  static String? emptyField(String? input) {
    if (input == null || input.isEmpty) {
      return 'Este campo não pode ser vazio.';
    }
    return null;
  }

  static String? invalidLength(String? input, int length) {
    if (input == null || input.isEmpty) return null;
    if (input.length < length) {
      return 'Campo deve conter no mínimo $length caractére(s).';
    }
    return null;
  }

  static String? invalidDouble(String? input) {
    if (input == null || input.isEmpty) return null;
    if (double.tryParse(input.replaceAll(',', '.')) == null) {
      return 'Campo deve ser um valor inteiro ou fracional.';
    }
    return null;
  }

  static String? invalidFullName(String? input) {
    if (emptyField(input) != null) {
      return emptyField(input);
    }
    if (input!.trim().split(' ').length < 2) {
      return 'Campo deve conter nome completo.';
    }
    if (input.contains(RegExp(r'[0-9]'))) {
      return 'Campo não deve conter números.';
    }
    if (RegExp(r'[$#@!%.*\|/?><,º;:&_ª•¶§∞¢£™πø¥†®œå()+-=]+').hasMatch(input)) {
      return 'Nome não pode conter caracteres especiais';
    }
    return null;
  }

  static String? invalidEmail(String? input) {
    if (emptyField(input) != null) {
      return emptyField(input);
    }
    if (!input!.contains('@')) {
      return 'E-mail inválido.';
    }
    return null;
  }

  static String? invalidSameField(String? input, String refer) {
    if (input != refer) {
      return 'Campos devem ser iguais.';
    }
    return null;
  }

  static String? invalidCPF(String? input) {
    if (!CPFValidator.isValid(input)) {
      return 'CPF inválido.';
    }
    return null;
  }

  static String? invalidCNPJ(String? input) {
    if (!CNPJValidator.isValid(input)) {
      return 'CNPJ inválido.';
    }
    return null;
  }

  static String? invalidGreaterThan(String? input, double refer) {
    final value = input?.replaceFirst(',', '.') ?? '';
    if (double.tryParse(value) != null) {
      if (double.parse(value) < refer) {
        return 'Campo deve ser maior ou igual à $refer';
      }
    } else if (double.tryParse(value) == null && value.isNotEmpty) {
      return 'Campo deve ser um número decimal.';
    }
    return null;
  }

  static String? invalidLessThan(String? input, double refer) {
    final value = input?.replaceFirst(',', '.') ?? '';
    if (double.tryParse(value) != null) {
      if (double.parse(value) > refer) {
        return 'Campo deve ser menor ou igual à $refer';
      }
    } else if (double.tryParse(value) == null && value.isNotEmpty) {
      return 'Campo deve ser um número decimal.';
    }
    return null;
  }

  static String? invalidCreditCard(String? input) {
    final result = CreditCardValidator().validateCCNum(
      input ?? '',
    );
    if (result.isValid) {
      return null;
    }
    return 'Número do cartão de crédito inválido.';
  }

  static String? invalidCardExpirationDate(String? input) {
    if (emptyField(input) != null) {
      return emptyField(input);
    }
    if (input!.length < 5) return 'Campo deve conter mês e ano.';

    final month = int.parse(input.substring(0, 2));
    final year = int.parse(input.substring(3, 5));

    final now = DateTime.now();

    final yearNow = int.parse(now.year.toString().substring(2));
    final monthNow = now.month;

    // Verifica se mês é menor que 01 e maior que 12
    if (month < 1 || month > 12) {
      return 'Mês inválido.';
    }
    if ((year == yearNow && month < monthNow) || year < yearNow) {
      return 'Cartão vencido';
    }
    return null;
  }
}
