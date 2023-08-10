import 'package:flutter/material.dart';
import '../data/database_helper.dart';
import '../view_models/v_uesrExamQuestion.dart';
//---------------------------------------------------------------------------------------------

class UserExamQuestions with ChangeNotifier {
  //-------------- feilds ---------------
  final database = DatabaseHelper.instance;
  List<VUserExamQuestion> _items = [];

  //-------------- getter ---------------
  List<VUserExamQuestion> get items {
    return [..._items];
  }

  //-------------- methods ---------------
// fethch all the user exam questions
  Future<void> fetchUserExamQuestions(int examId) async {
    final dataList = await database.getUserExamQuestions('v_userExamQuestions', examId);
    _items = dataList
        .map((item) => VUserExamQuestion(
              id: item['id'],
              examId: item['examId'],
              questionId: item['questionId'],
              questionText: item['questionText'],
            ))
        .toList();
    notifyListeners();
  }

// update user exam question
  Future<void> updateUserExamQuestion(int questionId, Map<String, dynamic> updatedData) async {
    try {
      await database.updateUserExamQuestion('userExamQuestions', updatedData, questionId);
    } catch (error) {
      print(error);
    }
  }
}
