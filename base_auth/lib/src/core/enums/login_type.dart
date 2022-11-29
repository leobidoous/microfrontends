enum LoginType { email, microsoft }

extension LoginTypeExt on LoginType {
  String get name {
    switch (this) {
      case LoginType.email:
        return 'E-mail';
      case LoginType.microsoft:
        return 'Microsoft';
    }
  }
}
