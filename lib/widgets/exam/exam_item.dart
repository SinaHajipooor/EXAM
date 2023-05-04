import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../view_models/v_userExam.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../screens/exam_screen.dart';
import '../elements/confirm_alert.dart';
import 'package:provider/provider.dart';
import '../../providers/UserExams.dart';
import '../../data/database_helper.dart';

//-------------------------------------------------------------------------------------------------------------------
class ExamItem extends StatelessWidget {
  //-------------- feilds ---------------
  final VUserExam exam;
  final int index;
  // final Function startUserExam;
  const ExamItem({
    required this.exam,
    required this.index,
    // required this.startUserExam,
  });

//------------- methods --------------

  Future<void> _startUserExam(BuildContext context) async {
    final updatedData = {'location': 'room12', 'file': 'ax'};
    await Provider.of<UserExams>(context, listen: false).startUserExam(exam.id, updatedData);
    Navigator.of(context).pushReplacementNamed(ExamScreen.routeName, arguments: exam.id);
  }

  _showAlert(BuildContext context) {
    Alert(
            context: context,
            type: AlertType.warning,
            title: "شروع آزمون",
            desc: "آیا مطمعن هستید که آزمون را شروع می کنید ؟",
            style: AlertStyle(
              titleStyle: const TextStyle(fontWeight: FontWeight.bold),
              descStyle: const TextStyle(fontSize: 14),
              overlayColor: Colors.black.withOpacity(0.6),
              animationType: AnimationType.grow,
              alertBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0), side: BorderSide.none),
            ),
            buttons: [
              DialogButton(
                onPressed: () => _startUserExam(context),
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

  //-------------- UI ---------------
  @override
  Widget build(BuildContext context) {
    // avatar background color
    Color avatar = Colors.blue;
    if (exam.examStatus == 'در حال برگزاری') {
      avatar = Colors.lightGreen.shade500;
    } else if (exam.examStatus == 'در انتظار شروع') {
      avatar = Colors.orange;
    } else if (exam.examStatus == 'پایان یافته') {
      avatar = Colors.grey.shade700;
    } else if (exam.examStatus == 'لغو شده') {
      avatar = Colors.red;
    }
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Container(
        height: 110,
        child: Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 7),
          child: Center(
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              leading: CircleAvatar(backgroundColor: avatar, child: Text('${index + 1}', style: const TextStyle(color: Colors.white))),
              title: Text('${exam.lessonName} - ${exam.courseName}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              subtitle: Text('مدت آزمون : ${exam.examPeriod} دقیقه', style: const TextStyle(fontSize: 14)),
              trailing: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Text(exam.examStatus, style: const TextStyle(fontSize: 12)),
                  exam.examStatus == 'در حال برگزاری'
                      ? IconButton(onPressed: () => _showAlert(context), icon: const Icon(Icons.play_arrow_sharp, color: Colors.green, size: 30))
                      : IconButton(
                          icon: const Icon(Icons.info, size: 25),
                          color: Colors.orange,
                          onPressed: () {},
                        ),
                ],
              ),
              onTap: () {},
            ),
          ),
        ),
      ),
    );
  }
}
