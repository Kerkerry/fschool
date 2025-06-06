import 'package:school/core/typedefs/typedefs.dart';
import 'package:school/core/usecase/usecases.dart';
import 'package:school/src/student/domain/entities/student.dart';
import 'package:school/src/student/domain/repositories/student_repository.dart';

class UpdateStudent extends UseCaseWithParams<void,Student>{
  final StudentRepository _repo;
  const UpdateStudent({required StudentRepository studentRepository}):_repo=studentRepository;

  @override
  ResultFuture<void> call(Student params) async=>_repo.updateStudent(student: params);
}