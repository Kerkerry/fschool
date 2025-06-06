import 'package:flutter_test/flutter_test.dart';
import 'package:school/src/student/data/datasources/student_remot_datasource_implementation.dart';
import 'package:school/src/student/domain/entities/student.dart';
import 'package:school/src/student/domain/usecases/create_student.dart';

void main(){
  final StudentDatasourceImplementation ds=StudentDatasourceImplementation();
  const student0=CreateStudentParams(
      username: "johnb",
      password: "bilj12",
      email: "billj@example.com",
      firstName: "John",
      role:"Student",
      lastName: "Billy");
  final student1=Student(
      id: 15,
      username: "billblank",
      password: "bilb76",
      email: "billj@example.com",
      firstName: "Bill",
      role:"Student",
      lastName: "Blanks",
      createdAt: null,
      lastLogin: DateTime.now()
  );
  test("Testing the apiendpoint", ()async{
    final students=await ds.getStudent(id: 15);
  });
}