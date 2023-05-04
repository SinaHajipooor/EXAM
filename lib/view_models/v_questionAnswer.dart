class VQuestionAnswer {
  final int id;
  final int questionId;
  final String answerText;
  final String? answerFile;
  final int? answerType;

  VQuestionAnswer({
    required this.id,
    required this.questionId,
    required this.answerText,
    this.answerFile,
    this.answerType,
  });
}
