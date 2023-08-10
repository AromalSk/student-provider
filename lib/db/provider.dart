import 'package:flutter/material.dart';
import 'package:students_add/db/functions/db_functions.dart';
import 'package:students_add/db/models/data_model.dart';

class userProvider extends ChangeNotifier {
  List<StudentModel> StudentList = [];
  List<StudentModel> filter = [];


  getAllfromProvider() async {
    StudentList = await getallStudents();
    notifyListeners();
  }

  addStudentsFromProvider(StudentModel value) async {
    await addStudent(value);
    StudentList = await getallStudents();
    notifyListeners();
  }

  deleteFromProvider(int id) async {
    await deleteStudent(id);
    await getallStudents();
    notifyListeners();
  }

  editFromProvider(int id, StudentModel value) async {
    await editStudent(id, value);
    await getallStudents();
    notifyListeners();
  }

  searchFromProvider(String query)async{
    filter = await search(query);
  }
}
