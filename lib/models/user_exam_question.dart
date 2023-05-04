class UserExamQuestion {
  // feilds
  final int id;
  final int userExamId;
  final int questionId;
  final String selectedAnswers;
  final int userAnswerId;
  final double questionScore;
  final DateTime uesrAnswerTime;
// constructor
  const UserExamQuestion({
    required this.id,
    required this.userExamId,
    required this.questionId,
    required this.selectedAnswers,
    required this.userAnswerId,
    required this.questionScore,
    required this.uesrAnswerTime,
  });
}
