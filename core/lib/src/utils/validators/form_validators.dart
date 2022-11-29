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
      return 'Campo aceita no mínimo $length caractére(s).';
    }
    return null;
  }
}
