import 'package:flutter/material.dart';
import '../../view_models/v_userExam.dart';

//-------------------------------------------------------------------------------------------------------------
class ExamDetailsDialog extends StatelessWidget {
  //--------------- feilds -------------------
  final VUserExam exam;

  const ExamDetailsDialog({Key? key, required this.exam}) : super(key: key);

  //--------------- UI -------------------

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Questions Count: ${exam.examQuestionsCount}'),
            Text('Start Time: ${exam.examStartTime}'),
            Text('End Time: ${exam.examEndTime}'),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    // Do something here
                  },
                  child: const Text('Action'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
