import 'package:flutter/material.dart';
import '../widgets/exam/exams_list.dart';

//---------------------------------------------------------------------------------------------

enum ExamStatus { WaitingToStart, OnPerform, Finished, Canceled }

class ExamsOverviewScreen extends StatefulWidget {
  const ExamsOverviewScreen({super.key});
//------------------ feilds ----------------------
  static const routeName = '/examsOverview';
  @override
  State<ExamsOverviewScreen> createState() => _ExamsOverviewScreenState();
}

class _ExamsOverviewScreenState extends State<ExamsOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('فهرست آزمون ها'), centerTitle: true),
      body: ExamsList(),
    );
  }
}
