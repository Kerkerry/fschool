import 'package:flutter_test/flutter_test.dart';
import 'package:school/src/student/data/datasources/student_remot_datasource_implementation.dart';
import 'package:school/src/student/domain/entities/student.dart';
import 'package:school/src/student/domain/usecases/create_student.dart';

void main(){
  final StudentDatasourceImplementation ds=StudentDatasourceImplementation();
  const student=CreateStudentParams(
      username: "johnb",
      password: "bilj1",
      email: "billj@example.com",
      firstName: "John",
      role:"Student",
      lastName: "Billy");
  final student1=Student(
      id: 18,
      username: "billblank",
      password: "bilb76",
      email: "billj@example.com",
      firstName: "Bill",
      role:"Student",
      lastName: "Blanks",
      createdAt: null,
      lastLogin: DateTime.now()
  );
  const student2=CreateStudentParams(
      username: "markhowels",
      password: "1234",
      email: "markh@example.com",
      firstName: "Mark",
      role:"Student",
      lastName: "Howels",
  );
  test("Testing the apiendpoint", ()async{
    final students=await ds.loginStudent(student: student2);
  });
}