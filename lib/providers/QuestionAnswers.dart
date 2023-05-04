import 'package:flutter/material.dart';
import '../data/database_helper.dart';
import '../view_models/v_questionAnswer.dart';

class QuestionAnswers with ChangeNotifier {
  //-------------- feilds ---------------
  final database = DatabaseHelper.instance;
  List<VQuestionAnswer> _items = [];
  //-------------- getter---------------
  List<VQuestionAnswer> get items {
    return [..._items];
  }

  //-------------- methods---------------
  Future<void> fetchQuestionAnswers(int questionId) async {
    final dataList = await database.getUserExamQuestionAnswers('v_questionAnswers', questionId);
    _items = dataList
        .map(
          (item) => VQuestionAnswer(
            id: item['id'],
            questionId: item['questionId'],
            answerText: item['answerText'],
            answerType: item['answerType'],
            answerFile: item['answerFile'],
          ),
        )
        .toList();
    notifyListeners();
  }
}
