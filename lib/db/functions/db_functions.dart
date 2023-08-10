
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:students_add/db/models/data_model.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);
ValueNotifier<List<StudentModel>> filteredItems = ValueNotifier([]);

Future<void> addStudent(StudentModel value)async{
  final studentDB =await Hive.openBox<StudentModel>('student_db');
  await studentDB.add(value);
}

Future<List<StudentModel>> getallStudents ()async{  
final studentDB =await Hive.openBox<StudentModel>('student_db');
studentListNotifier.value.clear();
studentListNotifier.value.addAll(studentDB.values);
return studentListNotifier.value;
}

Future<void> deleteStudent(int id)async{
  final studentDB =await Hive.openBox<StudentModel>('student_db');
  await studentDB.delete(id);
}

Future<void> editStudent (int id,StudentModel value) async{
   final studentDB =await Hive.openBox<StudentModel>('student_db');
   await studentDB.put(id, value);
}

Future<List<StudentModel>> search(String query) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  List<StudentModel> allStudents = studentDB.values.toList();

  if (query.isEmpty) {
    filteredItems.value ;
  } else {
    filteredItems.value = allStudents
        .where((student) => student.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
 
  return filteredItems.value;
}
