import 'package:exam/widgets/elements/spinner.dart';
import 'package:flutter/material.dart';
import '../exam/question.dart';
import 'package:provider/provider.dart';
import '../../providers/UserExamQuestions.dart';
import '../../view_models/v_uesrExamQuestion.dart';
import './answers_list_wrapper.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

//---------------------------------------------------------------------------------------------------------------------
// ignore: must_be_immutable
class QuestionsList extends StatefulWidget {
  //--------------- feilds ------------------
  int examId;
  QuestionsList(this.examId, {super.key});

  @override
  _QuestionsListState createState() => _QuestionsListState();
}

class _QuestionsListState extends State<QuestionsList> {
  //--------------- state ------------------
  List<VUserExamQuestion> questions = [];
  int _currentPageIndex = 0;
  bool _isLoading = false;
  int _selectedAnswerId = -1;
  //--------------- lifecycle ------------------

  @override
  void didChangeDependencies() {
    fetchExamQuestions();
    super.didChangeDependencies();
  }

//--------------- methods ------------------
  void fetchExamQuestions() async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<UserExamQuestions>(context, listen: false).fetchUserExamQuestions(widget.examId);
    setState(() {
      questions = Provider.of<UserExamQuestions>(context, listen: false).items;
      _isLoading = false;
    });
  }

  void answerOnSelect(id) {
    setState(() {
      _selectedAnswerId = id;
    });
  }

  _showAlert(BuildContext context) {
    Alert(
            context: context,
            type: AlertType.warning,
            title: "پایان آزمون",
            desc: "آیا از اتمام آزمون و ثبت همه پاسخ های خود مطمعن هستید ؟",
            style: AlertStyle(
              titleStyle: const TextStyle(fontWeight: FontWeight.bold),
              descStyle: const TextStyle(fontSize: 14),
              overlayColor: Colors.black.withOpacity(0.6),
              animationType: AnimationType.grow,
              alertBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0), side: BorderSide.none),
            ),
            buttons: [
              DialogButton(
                onPressed: () {},
                width: 120,
                color: const Color.fromRGBO(0, 179, 134, 1.0),
                child: const Text("بله", style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
              DialogButton(
                onPressed: () => Navigator.pop(context),
                width: 120,
                color: Colors.red,
                child: const Text("خیر", style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
            ],
            closeIcon: const Icon(Icons.close, color: Colors.red))
        .show();
  }

//--------------- UI------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: Spinner())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: (questions.isNotEmpty)
                      ? PageView.builder(
                          itemCount: questions.length,
                          controller: PageController(initialPage: _currentPageIndex),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: const EdgeInsets.only(top: 30, right: 6),
                              child: Question(index: _currentPageIndex + 1, text: questions[_currentPageIndex].questionText),
                            );
                          },
                          onPageChanged: (int index) {
                            setState(() {
                              _currentPageIndex = index;
                            });
                            print(questions[_currentPageIndex].id);
                          },
                        )
                      : const Center(
                          child: Text('سوالی یافت نشد'),
                        ),
                ),
                Expanded(
                  child: AnswersListWrapper(
                    key: UniqueKey(),
                    id: questions[_currentPageIndex].id,
                    selectedAnswerId: _selectedAnswerId,
                    // answerOnSelect: (id) => answerOnSelect(id),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 8, bottom: 80, top: 10),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedAnswerId = -1;
                      });
                    },
                    child: const Text('پاک کردن انتخاب', style: TextStyle(fontSize: 13)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10, bottom: 5),
                      child: ElevatedButton(
                        onPressed: _currentPageIndex > 0
                            ? () {
                                setState(() {
                                  _currentPageIndex--;
                                });
                              }
                            : null,
                        child: const Text('قبلی'),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10, bottom: 5),
                      child: _currentPageIndex < questions.length - 1
                          ? ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _currentPageIndex++;
                                });
                              },
                              child: const Text('بعدی'),
                            )
                          : ElevatedButton(
                              onPressed: () => _showAlert(context),
                              child: const Text('پایان'),
                            ),
                    )
                  ],
                )
              ],
            ),
    );
  }
}
