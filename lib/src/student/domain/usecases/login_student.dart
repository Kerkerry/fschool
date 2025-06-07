import 'package:school/core/typedefs/typedefs.dart';
import 'package:school/core/usecase/usecases.dart';
import 'package:school/src/student/domain/repositories/student_repository.dart';
import 'package:school/src/student/domain/usecases/create_student.dart';

class LoginStudent extends UseCaseWithParams<bool,CreateStudentParams>{
  final StudentRepository _repo;
  const LoginStudent({required StudentRepository studentRepository}):_repo=studentRepository;
  @override
  ResultFuture<bool> call(CreateStudentParams params)async=>_repo.loginStudent(student: params);

}