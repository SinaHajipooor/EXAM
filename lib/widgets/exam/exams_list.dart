import 'package:flutter/material.dart';
import './exam_item.dart';
import 'package:provider/provider.dart';
import '../../providers/UserExams.dart';
import '../elements/spinner.dart';
import '../../view_models/v_userExam.dart';

//-----------------------------------------------------------------------------------------------------------
class ExamsList extends StatefulWidget {
  @override
  State<ExamsList> createState() => _ExamsListState();
}

class _ExamsListState extends State<ExamsList> {
  //---------------- State -----------------
  List<VUserExam> userExams = [];
  bool _isLoading = false;
  //---------------- lifeCycle -----------------
  @override
  void didChangeDependencies() {
    fetchUserExams();
    super.didChangeDependencies();
  }

  //---------------- methods -----------------
  List<VUserExam> sortExamsByStatus(List<VUserExam> exams) {
    final order = ['در حال برگزاری', 'در انتظار شروع', 'پایان یافته', 'لغو شده'];
    return exams..sort((a, b) => order.indexOf(a.examStatus).compareTo(order.indexOf(b.examStatus)));
  }

  void fetchUserExams() async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<UserExams>(context, listen: false).fetchUserExams();
    setState(() {
      userExams = Provider.of<UserExams>(context, listen: false).items;
      _isLoading = false;
    });
  }

  //---------------- UI -----------------
  @override
  Widget build(BuildContext context) {
    final sortedExams = sortExamsByStatus(userExams);
    return _isLoading
        ? const Center(child: Spinner())
        : ListView.builder(
            itemCount: sortedExams.length,
            itemBuilder: (ctx, i) => ExamItem(exam: sortedExams[i], index: i),
          );
  }
}





















// class ExamsList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: FutureBuilder(
//           future: Provider.of<UserExams>(context, listen: false).fetchUserExams(),
//           builder: (ctx, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Spinner();
//             } else {
//               final userExams = Provider.of<UserExams>(context);
//               return ListView.builder(
//                 itemCount: userExams.items.length,
//                 itemBuilder: (context, index) {
//                   final exam = userExams.items[index];
//                   return Text(exam.lessonName); // replace ExamItem with your widget
//                 },
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
