import 'dart:async';

import 'package:exam/widgets/elements/circular_timer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/UserExams.dart';
import '../widgets/exam/questions_list.dart';
//----------------------------------------------------------------------------------------------------------------

class ExamScreen extends StatefulWidget {
  //---------------- feilds ------------------
  static const routeName = '/exam-screen';

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  // ---------------- state ------------------
  Timer? _timer;
  int _startSeconds = 0;
  int _elapsedSeconds = 0;
  // ---------------- lifecycle ------------------
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  // ---------------- methods ------------------
  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (_startSeconds <= 0) {
          _timer!.cancel();
        } else {
          _startSeconds = _startSeconds - 1;
          _elapsedSeconds = _elapsedSeconds + 1;
        }
      });
    });
  }

  //----------------UI ------------------
  @override
  Widget build(BuildContext context) {
    final examId = ModalRoute.of(context)!.settings.arguments as int;
    final selectedExam = Provider.of<UserExams>(context, listen: false).findById(examId);
    final remainingDuration = Duration(seconds: selectedExam.examPeriod * 60);
    final remaining = remainingDuration.inSeconds;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 70),
        child: AppBar(
          backgroundColor: Colors.white,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('نام درس : ${selectedExam.lessonName}'),
                      Text('نام دوره : ${selectedExam.courseName}'),
                      Text('تعداد سوالات : ${selectedExam.examQuestionsCount}'),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: CircularTimer(remaining),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      body: QuestionsList(examId),
    );
  }
}















//  SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Container(
//             margin: const EdgeInsets.only(top: 15),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 FutureBuilder(
//                     future: Provider.of<UserExamQuestions>(context, listen: false).fetchUserExamQuestions(examId),
//                     builder: (ctx, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return const Center(child: Spinner());
//                       } else {
//                         final userExamQuestions = Provider.of<UserExamQuestions>(context).items;
//                         return ListView.builder(itemCount: userExamQuestions.length, itemBuilder: (ctx, i) => Text(userExamQuestions[i].toString()));
//                       }
//                     }),
//                 Container(
//                   margin: const EdgeInsets.only(top: 50),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       AnswerWidget(
//                         answerText: 'test1',
//                         answerId: 1,
//                         selectedAnswerId: selectedAnswerId,
//                         onSelect: (id) {
//                           setState(() {
//                             selectedAnswerId = id;
//                           });
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   margin: const EdgeInsets.only(top: 30),
//                   child: TextButton(
//                     onPressed: () {
//                       setState(() {
//                         selectedAnswerId = -1;
//                       });
//                     },
//                     child: const Text('پاک کردن انتخاب'),
//                   ),
//                 ),
//                 Container(
//                   child: Row(
//                     children: [
//                       ElevatedButton(onPressed: () {}, child: const Text('قبلی')),
//                       ElevatedButton(onPressed: null, child: const Text('بعدی')),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),