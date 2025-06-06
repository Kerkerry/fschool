import 'package:equatable/equatable.dart';
import 'package:school/core/typedefs/typedefs.dart';
import 'package:school/core/usecase/usecases.dart';
import 'package:school/src/student/domain/repositories/student_repository.dart';

class CreateStudent extends UseCaseWithParams<void,CreateStudentParams>{
  final StudentRepository _repo;
  const CreateStudent({required StudentRepository studentRepository}):_repo=studentRepository;

  @override
  ResultFuture<void> call(CreateStudentParams params)async=>_repo.createStudent(student: params);
}

class CreateStudentParams extends Equatable{
  final String username;
  final String password;
  final String email;
  final String role;
  final String firstName;
  final String lastName;

  const CreateStudentParams({required this.username, required this.role, required this.password, required this.email, required this.firstName, required this.lastName});

  @override
  // TODO: implement props
  List<Object?> get props =>[username,password,email,firstName,lastName];
}