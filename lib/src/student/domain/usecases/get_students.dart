import 'package:school/core/typedefs/typedefs.dart';
import 'package:school/core/usecase/usecases.dart';
import 'package:school/src/student/domain/entities/student.dart';
import 'package:school/src/student/domain/repositories/student_repository.dart';

class GetStudents extends UseCaseWithoutParams<List<Student>>{
  final StudentRepository _repo;
  const GetStudents({required StudentRepository studentRepository}):_repo=studentRepository;

  @override
  ResultFuture<List<Student>> call()async=>_repo.getStudents();
}