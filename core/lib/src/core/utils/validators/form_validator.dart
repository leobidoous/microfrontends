class FormValidators {
  static String? emptyField(String? input) {
    if (input == null || input.isEmpty) {
      return 'Este campo não pode ser vazio.';
    }
    return null;
  }

  static String? invalidLength(String? input, int length) {
    if (emptyField(input) != null) {
      return emptyField(input);
    }
    if (input!.length < length) {
      return 'Campo deve conter no mínimo $length caractére(s).';
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
}
