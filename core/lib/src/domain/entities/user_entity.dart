class UserEntity {
  final String name;
  final String cpf;
  final String email;
  final String phone;
  final DateTime birth;
  final String id;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserEntity({
    required this.name,
    required this.cpf,
    required this.email,
    required this.phone,
    required this.birth,
    required this.id,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
}
