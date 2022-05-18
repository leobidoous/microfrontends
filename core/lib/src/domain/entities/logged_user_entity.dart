class LoggedUserEntity {
  final String name;
  final String email;
  final String phone;

  LoggedUserEntity({
    required this.name,
    required this.email,
    this.phone = '',
  });
}
