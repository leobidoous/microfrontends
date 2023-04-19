class RegisterQueries {
  static const String customerAlreadyExists = r'''
        query customerAlreadyExists($cpf: String!) {
          customerAlreadyExists(cpf: $cpf)
        }
      ''';
}
