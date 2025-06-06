import 'package:school/core/typedefs/typedefs.dart';
import 'package:school/core/usecase/usecases.dart';
import 'package:school/src/student/domain/repositories/student_repository.dart';

class DeleteStudent extends UseCaseWithParams<void,int>{
  final StudentRepository _repo;
  const DeleteStudent({required StudentRepository studentRepository}):_repo=studentRepository;

  @override
  ResultFuture<void> call(int params) async=>_repo.deleteStudent(id:params);

}