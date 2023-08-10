import '../../view_models/v_questionAnswer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/QuestionAnswers.dart';
import '../elements/spinner.dart';
import './answer.dart';

//---------------------------------------------------------------------------------------------------------------------
// ignore: must_be_immutable
class AnswersList extends StatefulWidget {
//-------------- feilds ---------------
  int questionId;
  int selectedAnswerId;
  // Function answerOnSelect;

  AnswersList({
    super.key,
    required this.questionId,
    required this.selectedAnswerId,
    // required this.answerOnSelect,
  });

  @override
  State<AnswersList> createState() => _AnswersListState();
}

class _AnswersListState extends State<AnswersList> {
//--------------- State ------------------
  // int _selectedAnswerId = -1;
  List<VQuestionAnswer> answers = [];
  bool _isLoading = false;

//--------------- lifeCycle ------------------
  @override
  void didChangeDependencies() {
    fetchQuestionAnswers();
    super.didChangeDependencies();
  }

//--------------- methods ------------------

  void fetchQuestionAnswers() async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<QuestionAnswers>(context, listen: false).fetchQuestionAnswers(widget.questionId);
    setState(() {
      answers = Provider.of<QuestionAnswers>(context, listen: false).items;
      _isLoading = false;
    });
  }

  void answerOnSelect(id) {
    setState(() {
      widget.selectedAnswerId = id;
    });
  }

//--------------- UI ------------------
  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: Spinner())
        : ListView.builder(
            itemCount: answers.length,
            itemBuilder: (ctx, i) => Answer(
              answerText: answers[i].answerText,
              answerId: answers[i].id,
              onSelect: (id) => answerOnSelect(id),
              selectedAnswerId: widget.selectedAnswerId,
            ),
          );
  }
}
