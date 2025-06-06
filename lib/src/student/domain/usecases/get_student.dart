import 'package:school/core/typedefs/typedefs.dart';
import 'package:school/core/usecase/usecases.dart';
import 'package:school/src/student/domain/entities/student.dart';
import 'package:school/src/student/domain/repositories/student_repository.dart';

class GetStudent extends UseCaseWithParams<Student,int>{
  final StudentRepository _repo;
  const GetStudent({required StudentRepository studentRepository}):_repo=studentRepository;

  @override
  ResultFuture<Student> call(int params)async=>_repo.getStudent(id: params);
}