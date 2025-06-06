import 'package:equatable/equatable.dart';
class Student extends Equatable{
  final int id;
  final String username;
  final String password;
  final String email;
  final String role;
  final String firstName;
  final String lastName;
  final DateTime? createdAt;
  final DateTime? lastLogin;

  const Student({required this.id, required this.username, required this.password, required this.email, required this.role, required this.firstName, required this.lastName, required this.createdAt, required this.lastLogin});

  @override
  // TODO: implement props
  List<Object?> get props => [id,username,password,email,firstName,lastName];
}
