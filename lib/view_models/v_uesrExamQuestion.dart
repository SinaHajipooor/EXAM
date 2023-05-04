class VUserExamQuestion {
  final int id;
  final int examId;
  final int questionId;
  final String questionText;
  final String? questionFile;

  VUserExamQuestion({
    required this.id,
    required this.examId,
    required this.questionId,
    required this.questionText,
    this.questionFile,
  });
}
