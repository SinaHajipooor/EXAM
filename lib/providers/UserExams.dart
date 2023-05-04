import 'package:flutter/material.dart';
import '../data/database_helper.dart';
import '../view_models/v_userExam.dart';

//---------------------------------------------------------------------------------------------
class UserExams with ChangeNotifier {
//-------------- feilds ---------------
  final database = DatabaseHelper.instance;
  List<VUserExam> _items = [];

//-------------- getter ---------------
  List<VUserExam> get items {
    return [..._items];
  }

//-------------- methods ---------------
// fetch all the user exams
  Future<void> fetchUserExams() async {
    final dataList = await database.getUserExams('v_userExams');
    _items = dataList
        .map((item) => VUserExam(
              examPeriod: item['examPeriod'],
              id: item['id'],
              examStartTime: item['examStartTime'],
              examEndTime: item['examEndTime'],
              examStatus: item['examStatus'],
              examQuestionsCount: item['examQuestionsCount'],
              courseName: item['courseName'],
              lessonName: item['lessonName'],
            ))
        .toList();
    notifyListeners();
  }

// fetch specefic user exam
  VUserExam findById(id) {
    return _items.firstWhere((userExam) => userExam.id == id);
  }

// start the user exam
  Future<void> startUserExam(int examId, Map<String, dynamic> updatedData) async {
    try {
      await database.updateUserExam(examId, updatedData, 'userExams');
    } catch (error) {
      print(error);
    }
    notifyListeners();
  }

// finish user exam
  Future<void> finishUserExam(int examId, Map<String, dynamic> updatedData) async {
    try {
      await database.updateUserExam(examId, updatedData, 'userExams');
    } catch (error) {
      print(error);
    }
    notifyListeners();
  }
}
