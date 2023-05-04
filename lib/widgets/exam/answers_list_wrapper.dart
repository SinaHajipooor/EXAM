import 'package:flutter/material.dart';
import './answers_list.dart';

class AnswersListWrapper extends StatefulWidget {
  final int id;
  // final Function answerOnSelect;
  final int selectedAnswerId;

  AnswersListWrapper({
    required Key key,
    required this.id,
    // required this.answerOnSelect,
    required this.selectedAnswerId,
  }) : super(key: key);

  @override
  _AnswersListWrapperState createState() => _AnswersListWrapperState();
}

class _AnswersListWrapperState extends State<AnswersListWrapper> {
  @override
  void didUpdateWidget(AnswersListWrapper oldWidget) {
    if (oldWidget.id != widget.id) {
      setState(() {});
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnswersList(
      questionId: widget.id,
      // answerOnSelect: widget.answerOnSelect,
      selectedAnswerId: widget.selectedAnswerId,
    );
  }
}
